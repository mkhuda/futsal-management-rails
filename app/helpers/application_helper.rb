module ApplicationHelper
	def dashboard?
		controller.class.name.split("::").first=="Dashboard"
	end
end
