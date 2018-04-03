class MusicianInfo < ActiveRecord::Base
	belongs_to :scout_profile
	belongs_to :instrument
end
