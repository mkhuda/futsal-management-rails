class DashboardAdmin::PricesController < ApplicationController
	before_filter :require_authorization

	add_breadcrumb "Dashboard", :dashboard_path
	
	def index
	
		@f = FutsalPlace.find_by(id: session[:futsal_place_id])
		add_breadcrumb @f.name, dashboard_admin_futsal_place_path(@f.id)
		add_breadcrumb "Tambahkan Harga"
		@price = Price.new
		@fp = FutsalPlace.find_by(id: session[:futsal_place_id])
	
	end

	def new
	
		@f = FutsalPlace.find_by(id: session[:futsal_place_id])
		add_breadcrumb @f.name, dashboard_admin_futsal_place_path(@f.id)
		add_breadcrumb "Tambahkan Harga"
		@price = Price.new
		@fp = FutsalPlace.find_by(id: session[:futsal_place_id])

	end

	def create
		@fp = FutsalPlace.find_by(id: session[:futsal_place_id])
		@price = @fp.prices.create(price_params)
		if @fp.save
			redirect_to new_dashboard_admin_price_path(@fp.id), :flash => { :success => "Jadwal Berhasil Ditambahkan" }
		else
			flash.now[:danger] = 'Gagal Melakukan Penambahan Jadwal'
			render 'new'
		end
	end

	def destroy
		@fp = FutsalPlace.find_by(id: session[:futsal_place_id])
		@f = Price.find(params[:id])
		if @f.destroy
			redirect_to new_dashboard_admin_price_path(@fp.id), :flash => { :success => "Jadwal Berhasil Dihapus" }
		else 
			flash.now[:danger] = 'Gagal Melakukan Penghapusan'
			render 'new'
		end
	
	end

	private
		def price_params
			params.require(:price).permit(:hari, :jam_mulai, :jam_akhir, :harga)
		end

	def require_authorization
		@u = User.find_by(id: session[:user_id])
		redirect_to root_path unless ((logged_in?[0]) && (logged_in?[1] == 'admin') && (logged_in?[2] == @u.futsal_place_id))
	end
end
