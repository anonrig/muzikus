class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
    redirect_to root_path
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @subject_id=params[:subject_id]
    @subject_title=params[:suject_title]
    if current_user && current_user.sabancimail != nil
      if Muzikususers.where("email = ?", current_user.sabancimail).count > 0
         if (Muzikususers.where("email = ?", current_user.sabancimail).first.isblogger == true)
            @post = Post.new
          end
        end

    else
      redirect_to subjects_path
        end
  end

  # GET /posts/1/edit
  def edit
    params[:subject_title]=Subject.find(params[:subject_id]).title
    if current_user && current_user.sabancimail != nil
      if Muzikususers.where("email = ?", current_user.sabancimail).count > 0
          if (Muzikususers.where("email = ?", current_user.sabancimail).first.isblogger == true) #FIXME: only owner should edit
         end
       end
   else
     redirect_to subjects_path
      end
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render action: 'show', status: :created, location: @post }
      else
        format.html { render action: 'new' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :subject_id, :user_id, :body)
    end
end
