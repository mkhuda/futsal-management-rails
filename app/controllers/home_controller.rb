class HomeController < ApplicationController

	add_breadcrumb "<i class='fa fa-home'></i> Beranda".html_safe, :root_path
	def index
		@fp = FutsalPlace.take(3)
	end

	def show
		@fp = FutsalPlace.find_by(id: params[:id])
		add_breadcrumb "Arena Futsal", :arena_path
		add_breadcrumb @fp.name
	end

	def list
		if params[:search]
			@fp = FutsalPlace.paginate(:page => params[:page], :per_page => 10).search(params[:search]).order('created_at DESC')
			add_breadcrumb "Hasil Pencarian"
		else
			@fp = FutsalPlace.paginate(:page => params[:page], :per_page => 10).order('created_at DESC')
			add_breadcrumb "List Arena Futsal"
		end
		
	end

end
