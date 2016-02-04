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
end
