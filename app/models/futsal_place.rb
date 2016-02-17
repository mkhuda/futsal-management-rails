class FutsalPlace < ActiveRecord::Base
	mount_uploader :image, ImageUploader
	belongs_to :user
	has_many :users
	has_many :prices
	has_many :bookings
	def self.search(query)
		where("name LIKE ? OR deskripsi LIKE ?", "%#{query}%", "%#{query}%")
	end
end
