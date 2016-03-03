class HomeController < ApplicationController

	before_action :set_locale

	add_breadcrumb "<i class='fa fa-home'></i> Beranda".html_safe, :root_path

	def index
		# @fp = FutsalPlace.order('created_at DESC').take(3)
		@fp = FutsalPlace.count_book()

	end

	def show
		@fp = FutsalPlace.find_by(id: params[:id])
		@lapangan = Booking.all.order(:jam_mulai)
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

			marker.lat futsal.latitude
			marker.lng futsal.longitude
			marker.picture({ :url => "http://androgan.com/ico/football.png", :width   => 32, :height  => 32
                 })
			marker.infowindow "<b>"+futsal_path+"</b><br><p>"+futsal.alamat+"</p><p class='text-danger'>"+futsal.phone+"</p>"
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

	private
		def testimoni_params
			params.require(:testimoni).permit(:name, :email, :isi)
		end
 
	def set_locale
	  I18n.locale = params[:locale] || I18n.default_locale
	end

end
