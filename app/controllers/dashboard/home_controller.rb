class Dashboard::HomeController < ApplicationController
	before_filter :require_authorization

  # get all futsal place use pagination
	def index
		@fp = FutsalPlace.paginate(:page => params[:page], :per_page => 20)
	end

	def require_authorization
		redirect_to root_path unless ((logged_in?[0]) && (logged_in?[1] == 'super'))
	end
end
