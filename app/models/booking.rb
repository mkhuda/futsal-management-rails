class Booking < ActiveRecord::Base
	belongs_to :futsal_place

	def self.booking_lapangan(a, b, c)
		where("lapangan = ? AND futsal_place_id = ? AND hari = ?", "#{a}", "#{b}", "#{c}")
	end
end
