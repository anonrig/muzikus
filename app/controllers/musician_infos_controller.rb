class MusicianInfosController < ApplicationController
	def create
		@newInfo = MusicianInfo.new(info_params)
		if not (@newInfo.instrument_id.nil? || @newInfo.experience.length == 0)
			if current_user && current_user.id == ScoutProfile.find(@newInfo.scout_profile_id).user_id
				@newInfo.save!
			end
		end
		redirect_to profile_path(current_user.email.split('@')[0])
	end

	def update
		@newInfo = MusicianInfo.find(params[:id])
		@newInfo.update(info_params)
		redirect_to profile_path(@newInfo.scout_profile.user.email.split('@')[0])
	end

	def destroy
		@info = MusicianInfo.find(params[:id])
		if current_user && current_user.id == ScoutProfile.find(@info.scout_profile_id).user_id
			@info.destroy!
		end
		redirect_to profile_path(@info.scout_profile.user.email.split('@')[0])
	end

	def info_params
      params.require(:musician_info).permit(:scout_profile_id, :instrument_id, :experience, :details)
    end
end
