class Dashboard::ReservationsController < ApplicationController
  before_filter :require_authorization

	include ApplicationHelper

	add_breadcrumb "Dashboard", :dashboard_path

	def index
	  add_breadcrumb "Reservasi"
		@rs = Reservation.paginate(:page => params[:page], :per_page => 10)

	end

	def create
		@action = params[:act]
    
    # need refactore [OR] move to helper
		if @action == "add"
			# Jika approve
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
				@update = @rs.update_attributes(:status => 1)
				respond_to do |format|
          msg = { :status => "ok" }
          format.json  { render :json => msg }
	    		end
			else
				respond_to do |format|
          msg = { :status => "problem" }
          format.json  { render :json => msg }
	    		end
			end
		elsif @action == "cancel"
			# Jika cancel
			@id = id_dec(params[:id])
			@rs = Reservation.find_by(id: @id)
			@name = @rs.name
			@jam_mulai = @rs.jam_mulai
			@jam_akhir = @rs.jam_akhir
			@hari = @rs.hari
			@lapangan = @rs.lapangan
			@fpid = @rs.futsal_place_id
			@book = Booking.find_by(:hari => @hari, :jam_mulai => @jam_mulai, :jam_akhir => @jam_akhir, :lapangan => @lapangan, :futsal_place_id => @fpid)
			if @book.destroy
				@update = @rs.update_attributes(:status => nil)
				respond_to do |format|
          msg = { :status => "ok" }
          format.json  { render :json => msg }
	    		end
			else
				respond_to do |format|
          msg = { :status => "problem" }
          format.json  { render :json => msg }
	    		end
			end
		elsif @action == "delete"
      # Jika delete
			@id = id_dec(params[:id])
			@rs = Reservation.find_by(id: @id)
			@name = @rs.name
			@jam_mulai = @rs.jam_mulai
			@jam_akhir = @rs.jam_akhir
			@hari = @rs.hari
			@lapangan = @rs.lapangan
			@fpid = @rs.futsal_place_id
			@book = Booking.find_by(:hari => @hari, :jam_mulai => @jam_mulai, :jam_akhir => @jam_akhir, :lapangan => @lapangan, :futsal_place_id => @fpid)
      
      ## NEED TO REFACTOR
      # Jika data ada di booking
			if @book.presence

        # Jika hapus data di booking sukses
        if @book.destroy

          # Jika hapus data di reservation sukses
          if @rs.destroy
            respond_to do |format|
                  msg = { :status => "ok" }
                  format.json  { render :json => msg }
    	    	end

          # Jika hapus data di reservation gagal
          else
            respond_to do |format|
              msg = { :status => "problem" }
              format.json  { render :json => msg }
    	    	end
          end

        # Jika hapus data di booking gagal
        else
          respond_to do |format|
            msg = { :status => "problem" }
            format.json  { render :json => msg }
  	    	end
        end

      # Jika data tidak ada di booking
			else

        # Jika hapus data di reservation sukses
        if @rs.destroy
          respond_to do |format|
            msg = { :status => "ok" }
            format.json  { render :json => msg }
  	    	end

        # Jika hapus data di reservation gagal
        else
          respond_to do |format|
            msg = { :status => "problem" }
            format.json  { render :json => msg }
  	    	end
        end

			end
		end



	end

	def destroy
	end

	def require_authorization
		redirect_to root_path unless ((logged_in?[0]) && (logged_in?[1] == 'super'))
	end

end
