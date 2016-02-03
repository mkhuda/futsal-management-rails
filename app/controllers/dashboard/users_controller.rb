class Dashboard::UsersController < ApplicationController
	before_filter :require_authorization

	add_breadcrumb "Dashboard", :dashboard_path
	add_breadcrumb "Users", :dashboard_users_path
	
	def index
		
		@user = User.paginate(:page => params[:page], :per_page => 20).where("role = ?", "admin")
		
	end

	def show
		@user = User.find_by(id: params[:id])
	end
	
	def new

		@user = User.new
		
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
		redirect_to root_path unless ((logged_in?[0]) && (logged_in?[1] == 'super'))
	end
end
