class DashboardAdmin::TestimonialsController < ApplicationController
	before_filter :require_authorization

	add_breadcrumb "Dashboard", :dashboard_path

	def index
		@fp = FutsalPlace.find_by(id: session[:futsal_place_id])
	end

	def destroy
		@fp = FutsalPlace.find_by(id: session[:futsal_place_id])
		@t = Testimonial.find(params[:id])
		@t.destroy
		redirect_to dashboard_admin_testimonials_path
	
	end


	def require_authorization
		@u = User.find_by(id: session[:user_id])
		redirect_to root_path unless ((logged_in?[0]) && (logged_in?[1] == 'admin') && (logged_in?[2] == @u.futsal_place_id))
	end
end
