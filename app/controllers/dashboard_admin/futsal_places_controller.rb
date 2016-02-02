class DashboardAdmin::FutsalPlacesController < ApplicationController
  before_filter :require_authorization

  add_breadcrumb "Dashboard", :dashboard_admin_path
  

  def index
  	@fp = FutsalPlace.find_by(id: session[:futsal_place_id])
  end

  def show
    @fp = FutsalPlace.find_by(id: session[:futsal_place_id])
    add_breadcrumb @fp.name, dashboard_admin_futsal_place_path(session[:futsal_place_id])
  end

  def edit
  	@fp = FutsalPlace.find_by(id: session[:futsal_place_id])
    @fplong = @fp.longitude
    @fplat = @fp.latitude
    add_breadcrumb @fp.name, edit_dashboard_admin_futsal_place_path(session[:futsal_place_id])
  end

  def update
    @fp = FutsalPlace.find_by(id: session[:futsal_place_id])
    if @fp.update(fp_params)
        redirect_to edit_dashboard_admin_futsal_place_path(session[:futsal_place_id]), :flash => { :success => "Pengeditan Berhasil" }
      else
        render 'edit'
      end
  end

  private
    def fp_params
      params.require(:futsal_place).permit(:name, :deskripsi, :alamat, :kecamatan, :longitude, :latitude, :phone, :email, :jumlah_lapangan, :image)
    end

  def require_authorization
  	@u = User.find_by(id: session[:user_id])
    redirect_to root_path unless ((logged_in?[0]) && (logged_in?[1] == 'admin') && (logged_in?[2] == @u.futsal_place_id))
  end
end
