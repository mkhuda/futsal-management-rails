class DashboardAdmin::BookingsController < ApplicationController
	before_filter :require_authorization

	add_breadcrumb "Dashboard", :dashboard_path
	
	def index
	
		@f = FutsalPlace.find_by(id: session[:futsal_place_id])
		add_breadcrumb @f.name, dashboard_admin_futsal_place_path(@f.id)
		add_breadcrumb "Tambahkan Hari Booking Pengunjung"
		@booking = Booking.new
		@fp = FutsalPlace.find_by(id: session[:futsal_place_id])

		@lapangan = Booking.all

		# .strftime('%d %B %Y')
		params[:hari].present? ? @hari = params[:hari].to_date.strftime('%A, %d %B %Y') : @hari = 'kosong'
		params[:hari].present? ? @sethari = params[:hari] : @sethari = Time.now.strftime("%Y-%m-%d")
	end

	def new
	
		@f = FutsalPlace.find_by(id: session[:futsal_place_id])
		add_breadcrumb @f.name, dashboard_admin_futsal_place_path(@f.id)
		add_breadcrumb "Tambahkan Hari Booking Pengunjung"
		@booking = Booking.new
		@fp = FutsalPlace.find_by(id: session[:futsal_place_id])

		@lapangan = Booking.all

	end

	def create
		@fp = FutsalPlace.find_by(id: session[:futsal_place_id])
		@booking = @fp.bookings.create(booking_params)
		if @fp.save
			redirect_to new_dashboard_admin_booking_path(@fp.id), :flash => { :success => "Booking Berhasil Ditambahkan" }
		else
			flash.now[:danger] = 'Gagal Melakukan Penambahan Booking'
			render 'new'
		end
	end

	def destroy
		@fp = FutsalPlace.find_by(id: session[:futsal_place_id])
		@f = Booking.find(params[:id])
		if @f.destroy
			redirect_to new_dashboard_admin_booking_path(@fp.id), :flash => { :success => "Booking Berhasil Dihapus" }
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
		@u = User.find_by(id: session[:user_id])
		redirect_to root_path unless ((logged_in?[0]) && (logged_in?[1] == 'admin') && (logged_in?[2] == @u.futsal_place_id))
	end
end
