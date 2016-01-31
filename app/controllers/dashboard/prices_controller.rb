class Dashboard::PricesController < ApplicationController
	def new
		@price = Price.new
		@fp = Price.find_by(futsal_place_id: params[:futsal_place_id])
	end
end
