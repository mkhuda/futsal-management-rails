module ApplicationHelper
	
	def dashboard?
		controller.class.name.split("::").first=="Dashboard"
	end

	def dashboard_admin?
		controller.class.name.split("::").first=="DashboardAdmin"
	end

	def session?
		controller_name == "sessions"
	end

	def account?
		controller_name == "account"
	end

	def list?
		action_name == "list"
	end

	def activemenu(menu)
		(action_name == menu) ? "active" : " "
	end
	
	def dashboard_header(type, title, icon)
		(icon == '') ? (icon = "fa-chevron-circle-right") : (icon = icon)

		("<div class='page-header grey'><#{type}> <i class='fa #{icon} fa-fw'></i> "+title+"</#{type}></div>").html_safe
	end
	
	def nl2br(s)
		s.gsub(/\n/, '<br>')
	end

	# fungsi untuk mengecek waktu booking apakah sudah pernah disetting
	def check_waktu(a,b,c,d,e)
		book = Booking.all.where(futsal_place_id: a, hari: b, lapangan: c, :jam_mulai => d..e)
	end
	
	# fungsi di controller
	def show_check(a,b,c,d,e)
		check = ""
		if check_waktu(a,b,c,d,e).present?
			check_waktu(a,b,c,d,e).each do |xx|
				if (e == xx.jam_mulai.strftime("%H:%M")) 
					check += "oke"
				else
					check += "tidak"
				end
			end
			
		else
			check += "oke"
		end

		# move variable availability @check to @show
		show = check
		return show
	end
	
	# fungsi untuk mengecek waktu booking apakah sudah pernah disetting
	def check_waktu_reservasi(a,b,c,d,e)
		book = Reservation.all.where(futsal_place_id: a, hari: b, lapangan: c, :jam_mulai => d..e)
	end
	
	# fungsi di controller
	def show_check_reservation(a,b,c,d,e)
		check = ""
		if check_waktu_reservasi(a,b,c,d,e).present?
			check_waktu_reservasi(a,b,c,d,e).each do |xx|
				if (e == xx.jam_mulai.strftime("%H:%M")) 
					check += "oke"
				else
					check += "tidak"
				end
			end
			
		else
			check += "oke"
		end

		# move variable availability @check to @show
		show = check

		# if @show contain "tidak"
		if show.include? "tidak"
			show = "booked"
		# else if ok then save it to db
		else
			show = "available"
		end
		return show
	end
end
