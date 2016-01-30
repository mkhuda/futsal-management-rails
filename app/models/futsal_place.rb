class FutsalPlace < ActiveRecord::Base
	mount_uploader :image, ImageUploader
	belongs_to :user
	has_many :prices
end
