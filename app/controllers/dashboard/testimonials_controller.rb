class Dashboard::TestimonialsController < ApplicationController
	before_filter :require_authorization

	add_breadcrumb "Dashboard", :dashboard_path

	def index
		@fp = FutsalPlace.find_by(id: params[:futsal_place_id])
	end

	def destroy
		@fp = FutsalPlace.find_by(id: params[:futsal_place_id])
		@t = Testimonial.find(params[:id])
		@t.destroy
		redirect_to dashboard_futsal_place_testimonials_path
	end

	def require_authorization
		redirect_to root_path unless ((logged_in?[0]) && (logged_in?[1] == 'super'))
	end
end
