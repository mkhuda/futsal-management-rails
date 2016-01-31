class Dashboard::FutsalPlacesController < ApplicationController
	before_filter :require_authorization

	add_breadcrumb "Dashboard", :dashboard_path
	add_breadcrumb "Futsal Places", :dashboard_futsal_places_path
	
	def index

		@fp = FutsalPlace.paginate(:page => params[:page], :per_page => 20)
		
	end

	def show
		@fp = FutsalPlace.find_by(id: params[:id])
	end
	
	def new

		@fp = FutsalPlace.new
		
	end

	def create 
		@user = User.find(current_user)
		@fp = @user.futsal_places.create(fp_params)
		if @fp.save
			redirect_to dashboard_futsal_places_path
		else
			render 'new'
		end
	end

	def edit
		@fp = FutsalPlace.find(params[:id])
		add_breadcrumb @fp.name, dashboard_futsal_place_path(@fp.id)
		add_breadcrumb "Edit", edit_dashboard_futsal_place_path(@fp.id)
	end

	def update
		@fp = FutsalPlace.find(params[:id])
		if @fp.update(fp_params)
	  		redirect_to dashboard_futsal_places_path
	  	else
	  		render 'edit'
	  	end
	end

	def destroy
		@fp = FutsalPlace.find(params[:id])
		@fp.destroy
		redirect_to dashboard_futsal_places_path
	end

	private
		def fp_params
			params.require(:futsal_place).permit(:name, :deskripsi, :alamat, :kecamatan, :longitude, :latitude, :phone, :email, :jumlah_lapangan, :image)
		end

	def require_authorization
		redirect_to root_path unless logged_in? 
	end
end
