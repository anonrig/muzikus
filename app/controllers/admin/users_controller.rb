class Admin::UsersController < BaseAdminController
    def index
        @users = User.all
        #TODO: User search etc.


        # Pagination
        @currentPage = params["page"].to_i
        if @currentPage == 0 then @currentPage = 1 end
        
        @pageCounter = 25
        @totalCount = @users.count
        
        @pageCount = @totalCount / @pageCounter
        if ((@totalCount % @pageCounter) > 0)
            @pageCount = @pageCount + 1
        end
        
        @users = @users.drop(@currentPage * @pageCounter - @pageCounter).take(@pageCounter)
    end

    def members
        @newMember = User.new
        @users = User.where(is_member: true)
        #TODO: User search

        # Pagination
        @currentPage = params["page"].to_i
        if @currentPage == 0 then @currentPage = 1 end
        
        @pageCounter = 25
        @totalCount = @users.count
        
        @pageCount = @totalCount / @pageCounter
        if ((@totalCount % @pageCounter) > 0)
            @pageCount = @pageCount + 1
        end
        
        @users = @users.drop(@currentPage * @pageCounter - @pageCounter).take(@pageCounter)
    end

    def create
        @newMember = User.new(user_params)
        if not User.find_by(email: @newMember.email+"@sabanciuniv.edu").nil?
            u = User.where(email: @newMember.email+"@sabanciuniv.edu").update(is_member: true, 
                                        is_yk: @newMember.is_yk,
                                        is_myk: @newMember.is_myk,
                                        is_workshop: @newMember.is_workshop,
                                        is_drum: @newMember.is_drum)
            redirect_to admin_user_path(u)
        else
            User.create(email: @newMember.email+"@sabanciuniv.edu",
                is_member: true, 
                is_yk: @newMember.is_yk,
                is_myk: @newMember.is_myk,
                is_workshop: @newMember.is_workshop,
                is_drum: @newMember.is_drum)
            redirect_to admin_members_path
        end
    end

    def show
        @user = User.where(id: params[:id]).first
        if @user.nil?
            render "error_pages/404", layout: false, status: :not_found
            return
        end
    end

    def update
        @user = User.where(id: params[:id]).first
        
        if @user.nil?
            render "error_pages/404", layout: false, status: :not_found
            return
        end

        @user.name = user_params["name"]
        @user.is_myk = user_params["is_myk"].nil? ? false : true
        @user.is_yk = user_params["is_yk"].nil? ? false : true
        @user.is_drum = user_params["is_drum"].nil? ? false : true
        @user.is_workshop = user_params["is_workshop"].nil? ? false : true

        @user.save!

        redirect_to admin_user_path(@user)
    end
    
    def destroy
        @user = User.find(params[:id])
        if @user.nil?
            render json: {}, status: :not_found
            return
        end
        
        @user.update(is_member: 0,
            is_yk: 0,
            is_myk: 0,
            is_drum: 0,
            is_workshop: 0)
        render json: {}, status: :ok
    end

    def blocked
    end

    private

    def user_params
        params.require(:user).permit(:name, :email, :is_myk, :is_yk, :is_drum, :is_workshop)
    end
end