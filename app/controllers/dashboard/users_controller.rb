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
		@user = User.create(user_params)
		if @user.save
			redirect_to dashboard_users_path, :flash => { :success => "User berhasil ditambahkan" }
		else
			render 'new'
		end
	end

	def edit
		@user = User.find(params[:id])
		add_breadcrumb @user.name, dashboard_user_path(@user.id)
		add_breadcrumb "Edit", edit_dashboard_user_path(@user.id)
	end

	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
	  		redirect_to dashboard_users_path, :flash => { :success => "User berhasil diedit" }
	  	else
	  		render 'edit'
	  	end
	end

	def destroy
		@user = User.find(params[:id])
		@user.destroy
		redirect_to dashboard_users_path, :flash => { :success => "User berhasil dihapus" }
	end

	private
		def user_params
			params.require(:user).permit(:name, :email, :futsal_place_id, :role, :password, :password_confirmation)
		end

    def require_authorization
      redirect_to root_path unless ((logged_in?[0]) && (logged_in?[1] == 'super'))
    end
end
