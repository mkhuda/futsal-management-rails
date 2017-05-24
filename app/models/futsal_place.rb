class FutsalPlace < ActiveRecord::Base
	mount_uploader :image, ImageUploader
	belongs_to :user
	has_many :users
	has_many :prices
	has_many :bookings
	has_many :galleries
	has_many :testimonials
	has_many :reservations
	
  def self.search(query)
		where("name LIKE ? OR deskripsi LIKE ?", "%#{query}%", "%#{query}%")
	end

	def self.count_book()
		# includes("bookings").where(bookings: { futsal_place_id: '#{id}' }).count
		select("futsal_places.id, futsal_places.name, futsal_places.deskripsi, futsal_places.image, count(bookings.id) as booking_count")
		.joins("LEFT JOIN bookings ON futsal_places.id = bookings.futsal_place_id")
		.group("futsal_places.id")
		.order("booking_count desc")
		.take(6)
	end

	def count_book_by_fp(id)
		includes("bookings").where(bookings: { futsal_place_id: '#{id}' }).count
	end
end
