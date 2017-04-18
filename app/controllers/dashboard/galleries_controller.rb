class Dashboard::GalleriesController < ApplicationController
	before_filter :require_authorization

	before_action :set_locale

	add_breadcrumb "Dashboard", :dashboard_path

	def index
		@f = FutsalPlace.find_by(id: params[:futsal_place_id])
		@gallery = Gallery.new
		add_breadcrumb @f.name, dashboard_futsal_place_path(@f.id)
		add_breadcrumb "Gallery"
	end

	def create
		@fp = FutsalPlace.find_by(id: params[:futsal_place_id])
		@gallery = @fp.galleries.create(gallery_params)
		
			if @fp.save
				# redirect_to dashboard_futsal_place_galleries_path(@fp.id), 
        # :flash => { :success => "Gambar Berhasil Ditambahkan" }
				@f = FutsalPlace.find_by(id: params[:futsal_place_id])
				@gallery = Gallery.new
				respond_to do |format|
					format.html { 
            redirect_to dashboard_futsal_place_galleries_path(@fp.id),
            :flash => { :success => "Gambar Berhasil Ditambahkan" } 
          }
					format.js
				end
			else
				render 'index', :flash => { :danger => "Gambar Gagal Ditambahkan" }
			end
	end

	def destroy	
		@fp = FutsalPlace.find_by(id: params[:futsal_place_id])
		@g = Gallery.find(params[:id])
		if @g.destroy
			@f = FutsalPlace.find_by(id: params[:futsal_place_id])
			@gallery = Gallery.new
			respond_to do |format|
				format.html {
          redirect_to dashboard_futsal_place_galleries_path(@fp.id),
          :flash => { :success => "Gambar Berhasil Ditambahkan" } 
        }
				format.js
			end
		end 
	end

	private
		def gallery_params
			params.require(:gallery).permit(:image)
		end

	def require_authorization
		redirect_to root_path unless ((logged_in?[0]) && (logged_in?[1] == 'super'))
	end

	def set_locale
	  I18n.locale = params[:locale] || I18n.default_locale
	end
end
