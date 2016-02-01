module ApplicationHelper
	
	def dashboard?
		# jika adalah dashboard
		controller.class.name.split("::").first=="Dashboard"
	end

	def dashboard_admin?
		controller.class.name.split("::").first=="DashboardAdmin"
	end

	def session?
		# jika adalah dashboard
		controller_name == "sessions"
	end

	def list?
		action_name == "list"
	end

	def activemenu(menu)
		(action_name == menu) ? "active" : " "
	end
end
