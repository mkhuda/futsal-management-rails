class Dashboard::HomeController < ApplicationController
	before_filter :require_authorization

	def index
		@a1 = session[:user_id]
		@a2 = session[:role]
		@a3 = session[:futsal_place_id]
	end

	def require_authorization
		redirect_to root_path unless ((logged_in?[0]) && (logged_in?[1] == 'super'))
	end
end
