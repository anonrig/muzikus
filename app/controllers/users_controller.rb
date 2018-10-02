class UsersController < ApplicationController
  before_action :set_rights, except: [:index, :create]

  def index
    if current_user && current_user.is_myk
      @users = User.all
      @newMember = User.new
    else
      redirect_to root_path
    end
  end

  def show
    @user = User.find_by_email(params[:email] + "@sabanciuniv.edu")
    if @user.id == current_user.id
      if current_user.scout_profile.nil?        
        @newScout = ScoutProfile.new
        render "create"
      end
    else
      if (not @user.is_member) || @user.scout_profile.nil? || @user.scout_profile.is_hidden
        redirect_to root_path
      end
    end

    @allRes = @user.reservations.order('id DESC')
    
  	@scout = @user.scout_profile    
    @newInstrument = MusicianInfo.new
    @allInst = Instrument.all

  end

  def create
    if current_user && current_user.is_myk
      @newMember = User.new(user_params)
      if not User.find_by(email: @newMember.email+"@sabanciuniv.edu").nil?
        User.where(email: @newMember.email+"@sabanciuniv.edu").update(is_member: @newMember.is_member, 
                                        is_yk: @newMember.is_yk,
                                        is_myk: @newMember.is_myk,
                                        is_workshop: @newMember.is_workshop,
                                        is_drum: @newMember.is_drum)
        redirect_to admin_users_path
      else
        User.create(email: @newMember.email+"@sabanciuniv.edu",
              is_member: @newMember.is_member, 
              is_yk: @newMember.is_yk,
              is_myk: @newMember.is_myk,
              is_workshop: @newMember.is_workshop,
              is_drum: @newMember.is_drum)
        redirect_to admin_users_path
      end
    else
      redirect_to root_path
    end
  end

  def destroy
    if current_user && current_user.is_myk
      @user = User.find(params[:id])
      @user.update(is_member: 0,
            is_yk: 0,
            is_myk: 0,
            is_drum: 0,
            is_workshop: 0)
      redirect_to admin_users_path
    else
      redirect_to root_path
    end
  end

  def update
    @user = User.find(params[:id])
    if current_user && current_user.id == @user.id
      @user.update(user_params)
      redirect_to profile_path(@user.email.split('@')[0])
    else
      redirect_to profile_path(@user.email.split('@')[0])
    end
  end

  def updatescout
  end

  private
  
    def user_params
      params.require(:user).permit(:email, :is_member, :is_yk, :is_myk, :is_workshop, :is_drum, :phone_num)
    end

    def set_rights
      if not (current_user && current_user.is_member)
        redirect_to root_path
      end
    end

end
