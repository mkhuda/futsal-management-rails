class Dashboard::BookingsController < ApplicationController
	before_filter :require_authorization

	include ApplicationHelper

	before_action :set_locale

	add_breadcrumb "Dashboard", :dashboard_path

	def index
	
		@f = FutsalPlace.find_by(id: params[:futsal_place_id])
		add_breadcrumb @f.name, dashboard_futsal_place_path(@f.id)
		add_breadcrumb "Booking Pengunjung"
		@booking = Booking.new
		@fp = FutsalPlace.find_by(id: params[:futsal_place_id])

		@lapangan = Booking.all.order(:jam_mulai)

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

		@lapangan = Booking.all.order(:jam_mulai)

		params[:hari].present? ? @hari = params[:hari].to_date.strftime('%A, %d %B %Y') : @hari = Time.now.strftime('%A, %d %B %Y')
		params[:hari].present? ? @sethari = params[:hari] : @sethari = Time.now.strftime("%Y-%m-%d")

	end

	def create
		@hari = params[:booking][:hari]
		@lap = params[:booking][:lapangan]
		@jmulai = params[:booking][:jam_mulai]
		@jakhir = params[:booking][:jam_akhir]
		# @jmulai = Time.strptime(params[:booking][:jam_mulai], "%I:%M %p").strftime("%H:%M")
		# @jakhir = Time.strptime(params[:booking][:jam_akhir], "%I:%M %p").strftime("%H:%M")
		@fp = FutsalPlace.find_by(id: params[:futsal_place_id])
		@check = ""

		# checking availability from ApplicationHelper
		if check_waktu(params[:futsal_place_id],@hari,@lap,@jmulai,@jakhir).present?
			check_waktu(params[:futsal_place_id],@hari,@lap,@jmulai,@jakhir).each do |a|
				if (@jakhir == a.jam_mulai.strftime("%H:%M")) 
					@check += "oke"
				else
					@check += "tidak"
				end
			end
			
		else
			@check += "oke"
			
		end

		# move variable availability @check to @show
		@show = @check

		# if @show contain "tidak"
		if @show.include? "tidak"
			@show = "booked"
		# else if ok then save it to db
		else
			@fp = FutsalPlace.find_by(id: params[:futsal_place_id])
			@booking = @fp.bookings.create(booking_params)
			if @fp.save
				@lapangan = Booking.all.order(:jam_mulai)

				@hari = params[:booking][:hari]
				@sethari = params[:booking][:hari]
				
				@show = "oke"
				respond_to do |format|
					format.html { redirect_to dashboard_futsal_place_bookings_path(@fp.id, :hari => @hari.to_date.strftime('%Y-%m-%d')), :flash => { :success => "Booking Berhasil Ditambahkan" } }
					format.js
				end
			else
				@show = "error"
			end
			
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
