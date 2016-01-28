class FutsalPlace < ActiveRecord::Base
	has_many :fields
	has_many :prices
end
