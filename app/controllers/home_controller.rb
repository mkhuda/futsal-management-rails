class HomeController < ApplicationController

	before_action :set_locale

	autocomplete :futsal_place, :name, :full => true

	add_breadcrumb "<i class='fa fa-home'></i> Beranda".html_safe, :root_path
	
	include ApplicationHelper

	def index
		@fp = FutsalPlace.count_book()
		@futsal = FutsalPlace.new

	end

	def show
		@fp = FutsalPlace.find_by(id: params[:id])
		@f = FutsalPlace.find_by(id: params[:id])
		@lapangan = Booking.all.order(:jam_mulai)
		@reservation = Reservation.new
		params[:hari].present? ? @hari = params[:hari].to_date.strftime('%A, %d %B %Y') : @hari = Time.now.strftime('%A, %d %B %Y')
		params[:hari].present? ? @sethari = params[:hari] : @sethari = Time.now.strftime("%Y-%m-%d")

		@testimoni = Testimonial.new
		add_breadcrumb "Arena Futsal", :arena_path
		add_breadcrumb @fp.name
	end

	def map
		@fp = FutsalPlace.all
		@hashmap = Gmaps4rails.build_markers(@fp) do |futsal, marker|
			futsal_path = view_context.link_to futsal.name, showarena_path(futsal.id, (futsal.name).gsub(' ', '-').downcase)
			image_show = futsal.image_url(:thumb)

			marker.lat futsal.latitude
			marker.lng futsal.longitude
			marker.picture({ :url => "http://45.32.252.124/sites/androgan/ico/football.png", :width   => 32, :height  => 32
                 })
			marker.infowindow "<b>"+futsal_path+"</b><br><p>"+futsal.alamat+"</p><p class='text-danger'>"+futsal.phone+"</p>"+"<img class='img-thumbnail img-responsive' src="+image_show+">"
		end
	end

	def list
		if params[:search]
			@fp = FutsalPlace.paginate(:page => params[:page], :per_page => 10).search(params[:search]).order('created_at DESC')
			add_breadcrumb "Hasil Pencarian", :arena_path
		else
			@fp = FutsalPlace.paginate(:page => params[:page], :per_page => 10).order('created_at DESC')
			add_breadcrumb "List Arena Futsal"
		end
		
	end

	def createtestimoni
		@fp = FutsalPlace.find_by(id: params[:futsal_place_id])
		@testimoni = @fp.testimonials.create(testimoni_params)
		if @fp.save
			redirect_to showarena_path(@fp.id, (@fp.name).gsub(' ', '-').downcase, :anchor => "testimoni")
		else
			render 'new'
		end
	end
	
	def createreservation
		@id = params[:futsal_reservation_id]
		@hari = params[:reservation][:hari]
		@lap = params[:reservation][:lapangan]
		@jmulai = params[:reservation][:jam_mulai]
		@jakhir = params[:reservation][:jam_akhir]
		@fp = FutsalPlace.find_by(id: @id)
		@check_one = ""
		@check_two = ""
		@show = ""
		
		# checking availability from ApplicationHelper
		@check_one = show_check(@id,@hari,@lap,@jmulai,@jakhir)
		@check_two = show_check_reservation(@id,@hari,@lap,@jmulai,@jakhir)
		
		if @check_one == "booked"
			@show = "booked"
		else
			if @check_two == "booked"
				@show = "booked"
			else
				@fp = FutsalPlace.find_by(id: @id)
				@reservation = @fp.reservations.create(reservation_params)
				if @fp.save

					@show = "available"
					respond_to do |format|
						format.js
					end
				else
					@show = "error"
				end
			end
		end
		
	end

	private
		def testimoni_params
			params.require(:testimoni).permit(:name, :email, :isi)
		end
		
		def reservation_params
			params.require(:reservation).permit(:name, :email, :phone, :jam_mulai, :jam_akhir, :lapangan, :hari)
		end
 
	def set_locale
	  I18n.locale = params[:locale] || I18n.default_locale
	end

end
