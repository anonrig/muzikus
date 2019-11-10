class ScoutProfilesController < ApplicationController
	before_action :maintenance, only: :index

	def index
		members = User.where(is_member: true)
		@scouts = []
		members.each do |m|
			if m.scout_profile && (not m.scout_profile.is_hidden)
				@scouts << m.scout_profile
			end
		end
	end

	def create
		@newProfile = ScoutProfile.new(scout_params)
		@newProfile.is_hidden = false
		if current_user && current_user.id == @newProfile.user_id
			@newProfile.save!
			redirect_to profile_path(current_user.email.split('@')[0])
		else
			redirect_to profile_path(current_user.email.split('@')[0])
		end
	end

	def update
		@profile = ScoutProfile.find(params[:id])
		if current_user && current_user.id == @profile.user_id
			@profile.update(scout_params)
		end
		redirect_to profile_path(@profile.user.email.split('@')[0])
	end

	def scout_params
      params.require(:scout_profile).permit(:user_id, :bio, :birthday, :is_hidden, :stage_exp, :vocal_exp)
    end
end
