class Dashboard::ReservationsController < ApplicationController
  before_filter :require_authorization

	include ApplicationHelper

	before_action :set_locale

	add_breadcrumb "Dashboard", :dashboard_path

	def index
	
		@rs = Reservation.paginate(:page => params[:page], :per_page => 10)

	end

	def create
	end

	def destroy
	end

	def require_authorization
		redirect_to root_path unless ((logged_in?[0]) && (logged_in?[1] == 'super'))
	end

	def set_locale
	  I18n.locale = params[:locale] || I18n.default_locale
	end
end
