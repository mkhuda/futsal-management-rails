class Dashboard::BookingsController < ApplicationController
	before_filter :require_authorization

	before_action :set_locale

	add_breadcrumb "Dashboard", :dashboard_path

	def index
	
		@f = FutsalPlace.find_by(id: params[:futsal_place_id])
		add_breadcrumb @f.name, dashboard_futsal_place_path(@f.id)
		add_breadcrumb "Booking Pengunjung"
		@booking = Booking.new
		@fp = FutsalPlace.find_by(id: params[:futsal_place_id])

		@lapangan = Booking.all

		# .strftime('%d %B %Y')
		params[:hari].present? ? @hari = params[:hari].to_date.strftime('%A, %d %B %Y') : @hari = Time.now.strftime('%A, %d %B %Y')
		params[:hari].present? ? @sethari = params[:hari] : @sethari = Time.now.strftime("%Y-%m-%d")
	end

	def new
	
		@f = FutsalPlace.find_by(id: params[:futsal_place_id])
		add_breadcrumb @f.name, dashboard_futsal_place_path(@f.id)
		add_breadcrumb "Booking", dashboard_futsal_place_bookings_path(@f.id)
		add_breadcrumb "Tambahkan Hari Booking Pengunjung"
		@booking = Booking.new
		@fp = FutsalPlace.find_by(id: params[:futsal_place_id])

		@lapangan = Booking.all

	end

	def create
		@hari = params[:booking][:hari]
		@fp = FutsalPlace.find_by(id: params[:futsal_place_id])
		@booking = @fp.bookings.create(booking_params)
		if @fp.save
			redirect_to dashboard_futsal_place_bookings_path(@fp.id, :hari => @hari.to_date.strftime('%Y-%m-%d')), :flash => { :success => "Booking Berhasil Ditambahkan" }
		else
			flash.now[:danger] = 'Gagal Melakukan Penambahan Booking'
			render 'new'
		end
	end

	def destroy
		session[:return_to] ||= request.referer
		@fp = FutsalPlace.find_by(id: params[:futsal_place_id])
		@f = Booking.find(params[:id])
		if @f.destroy
			redirect_to session.delete(:return_to), :flash => { :success => "Booking Berhasil Dihapus" }
		else 
			flash.now[:danger] = 'Gagal Melakukan Penghapusan Booking'
			render 'new'
		end
	
	end

	private
		def booking_params
			params.require(:booking).permit(:hari, :jam_mulai, :jam_akhir, :lapangan)
		end

	def require_authorization
		redirect_to root_path unless ((logged_in?[0]) && (logged_in?[1] == 'super'))
	end

	def set_locale
	  I18n.locale = params[:locale] || I18n.default_locale
	end
end
