class ScoutProfile < ActiveRecord::Base
	belongs_to :user
	has_many :musician_infos
	has_many :instrument, through: :musician_infos
end
