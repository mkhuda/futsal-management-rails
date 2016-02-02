class DashboardAdmin::HomeController < ApplicationController
  def index
  	@fp = FutsalPlace.find_by(id: session[:futsal_place_id])
  end
end
