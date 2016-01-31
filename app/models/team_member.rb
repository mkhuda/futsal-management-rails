class TeamMember < ActiveRecord::Base
	has_many :user_members
	has_many :futsal_places, through: :usages
end
