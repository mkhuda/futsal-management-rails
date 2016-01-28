class Field < ActiveRecord::Base
	belongs_to :futsal_place
	has_many :team_members, through: :usages
end
