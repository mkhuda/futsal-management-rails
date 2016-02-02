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

	def list?
		action_name == "list"
	end

	def activemenu(menu)
		(action_name == menu) ? "active" : " "
	end
	
	def dashboard_header(type, title)
		("<div class='page-header grey'><#{type}> <i class='fa fa-chevron-circle-right fa-fw'></i> "+title+"</#{type}></div>").html_safe
	end
end
