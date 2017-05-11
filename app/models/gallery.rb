class Gallery < ActiveRecord::Base

	mount_uploader :image, GalleryUploader
	belongs_to :futsal_place

end
