class ScoutController < ApplicationController
  def index
  	if current_user
  		@current = Scout.where("user_id = ?", current_user.id).first
  		
  		if @current.nil?
  			redirect_to new_scout_path
  		end
  		
  		@allScout = Scout.page(params[:page]).per(20).order(:BirinciEns)
  	else 
  		redirect_to root_path
  	end
  end
#GET REQUEST
  def new
  	if current_user
  		@current = Scout.where("user_id = ?", current_user.id).first
  		if @current
  			redirect_to scout_path
  		else
	  		@newUser = Scout.new
	  		@reservation = Reservations.new
  		end
  	else 
  		redirect_to root_path
  	end
  end
  
#POST REQUEST
  def create
  	@isSaved = false
  	@newUser = Scout.new(scout_params)
  	@newUser.user_id = current_user.id
  	
  	if Scout.where("user_id = ?", current_user.id).first == nil
  		@newUser.save
  		@isSaved = true
  	end
  	
  	respond_to do |format|
  		if @isSaved 
  			format.html { redirect_to scout_path, notice: '<div class="alert alert-success">Success! Your account is created.</div>'.html_safe }
  		else
  			format.html { redirect_to new_scout_path, notice: '<div class="alert alert-info">There is a problem with your registration</div>'.html_safe}
  		end
  	end
  end
  
  def 

  def edit

  	if current_user
  		@newUser = Scout.where("user_id = ?", current_user.id).first
  		
  	else
  		redirect_to root_path
  	end
  end
  
  private

  #assuming you're using params[:support]
  def scout_params
    params.require(:scout).permit(:BirinciEns, :BirinciSev, :BirinciYil, :IkinciEns, :IkinciSev, :IkinciYil, :VokalYetenek, :SahneTecrubesi, :UyeGruplar, :SevdiginGruplar)
  end
end
