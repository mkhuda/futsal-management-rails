class Dashboard::HomeController < ApplicationController
	before_filter :require_authorization

	def index
		
	end

	def require_authorization
		redirect_to root_path unless logged_in? 
	end
end
