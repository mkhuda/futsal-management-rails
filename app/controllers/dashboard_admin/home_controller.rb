class DashboardAdmin::HomeController < ApplicationController
  before_filter :require_authorization
 
  # dashboard admin for futsal place
  def index
  	@fp = FutsalPlace.find_by(id: session[:futsal_place_id])
  end
  
  def require_authorization
  	@u = User.find_by(id: session[:user_id])
    redirect_to root_path unless ((logged_in?[0]) && (logged_in?[1] == 'admin') && (logged_in?[2] == @u.futsal_place_id))
  end
  
end
