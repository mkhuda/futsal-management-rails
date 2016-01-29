class Dashboard::FutsalPlacesController < ApplicationController
	before_filter :require_authorization

	add_breadcrumb "Dashboard", :dashboard_path
	add_breadcrumb "Futsal Places", :dashboard_futsal_places_path
	
	def index
		
	end
	
	def new
		
	end
end
