class Usage < ActiveRecord::Base
	belongs_to :field
	belongs_to :team_member
end
