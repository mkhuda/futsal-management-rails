class Dashboard::ReservationsController < ApplicationController
  before_filter :require_authorization

	include ApplicationHelper

	add_breadcrumb "Dashboard", :dashboard_path

	def index
	
		@rs = Reservation.paginate(:page => params[:page], :per_page => 10)

	end

	def create

		@id = id_dec(params[:id])
		@rs = Reservation.find_by(id: @id)
		@name = @rs.name
		@jam_mulai = @rs.jam_mulai
		@jam_akhir = @rs.jam_akhir
		@hari = @rs.hari
		@lapangan = @rs.lapangan
		@fpid = @rs.futsal_place_id
		@book = Booking.new(:hari => @hari, :jam_mulai => @jam_mulai, :jam_akhir => @jam_akhir, :lapangan => @lapangan, :futsal_place_id => @fpid)
		if @book.save
			@status = "ok"
			@update = @rs.update_attributes(:status => 1)
			respond_to do |format|
        		format.js
    		end
		else
			@status = "problem"
			respond_to do |format|
        		format.js
    		end
		end
		
	end

	def destroy
	end

	def require_authorization
		redirect_to root_path unless ((logged_in?[0]) && (logged_in?[1] == 'super'))
	end

end
