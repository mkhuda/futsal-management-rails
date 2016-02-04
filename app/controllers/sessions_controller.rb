class SessionsController < ApplicationController
  	def new
		if logged_in?[0]
			redirect_to dashboard_path
		else 
		end
	end

	def create
		# mencari detail user berdasarkan email untuk keperluan username login
		user = User.find_by(email: params[:session][:email].downcase)

		# jika user email (true) dan form session[password] yang telah di authenticate (true)
		if user && user.authenticate(params[:session][:password])
			log_in user
	  		params[:session][:remember_me] == '1' ? remember(user) : forget(user)
	  		if logged_in?[1] == 'super'
				redirect_to dashboard_path
			else
				redirect_to dashboard_admin_path
			end
		else
			flash.now[:danger] = 'Invalid email/password combination'
			render 'new'
		end
		
	end

	def destroy
		log_out if logged_in?[0]
    	redirect_to root_path
	end
end
