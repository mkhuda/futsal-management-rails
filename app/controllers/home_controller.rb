class HomeController < ApplicationController

	add_breadcrumb "<i class='fa fa-home'></i> Beranda".html_safe, :root_path
	def index
		@fp = FutsalPlace.order('created_at DESC').take(3)
	end

	def show
		@fp = FutsalPlace.find_by(id: params[:id])
		@lapangan = Booking.all
		params[:hari].present? ? @hari = params[:hari].to_date.strftime('%A, %d %B %Y') : @hari = Time.now.strftime('%A, %d %B %Y')
		params[:hari].present? ? @sethari = params[:hari] : @sethari = Time.now.strftime("%Y-%m-%d")
		add_breadcrumb "Arena Futsal", :arena_path
		add_breadcrumb @fp.name
		
		respond_to do |format|
			format.html
			format.js
		end
	end

	def map
		@fp = FutsalPlace.all
		@hashmap = Gmaps4rails.build_markers(@fp) do |futsal, marker|
			futsal_path = view_context.link_to futsal.name, showarena_path(futsal.id, (futsal.name).gsub(' ', '-').downcase)

			marker.lat futsal.latitude
			marker.lng futsal.longitude
			marker.picture({ :url => "http://androgan.com/ico/football.png", :width   => 32, :height  => 32
                 })
			marker.infowindow "<b>"+futsal_path+"</b><br><p>"+futsal.alamat+"</p>"
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

end
