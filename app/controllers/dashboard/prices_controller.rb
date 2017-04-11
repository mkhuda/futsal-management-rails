class Dashboard::PricesController < ApplicationController
	before_filter :require_authorization

	add_breadcrumb "Dashboard", :dashboard_path

	def new
		@f = FutsalPlace.find_by(id: params[:futsal_place_id])
		add_breadcrumb @f.name, dashboard_futsal_place_path(@f.id)
		add_breadcrumb "Tambahkan Harga"
		@price = Price.new
		@fp = FutsalPlace.find_by(id: params[:futsal_place_id])
	end

	def create
		@fp = FutsalPlace.find_by(id: params[:futsal_place_id])
		@price = @fp.prices.create(price_params)
		if @fp.save
			redirect_to new_dashboard_futsal_place_price_path(@fp.id)
		else
			render 'new'
		end
	end

	def destroy
		@fp = FutsalPlace.find_by(id: params[:futsal_place_id])
		@f = Price.find(params[:id])
		@f.destroy
		redirect_to new_dashboard_futsal_place_price_path(@fp.id)
	
	end

	private
		def price_params
			params.require(:price).permit(:hari, :jam_mulai, :jam_akhir, :harga)
		end

	def require_authorization
		redirect_to root_path unless ((logged_in?[0]) && (logged_in?[1] == 'super'))
	end
end
