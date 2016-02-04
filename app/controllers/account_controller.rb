class AccountController < ApplicationController
	before_filter :require_authorization
	
	def index
		@account = User.find_by(id: session[:user_id])
	end

	def update
		@account = User.find_by(id: session[:user_id])
		if @account.authenticate(params[:old])
			if @account.update_attributes(account_params)
				redirect_to account_path, :flash => {:success => "Update password berhasil"}
			else
				flash.now[:danger] = 'Gagal Melakukan Update'
				render 'index'
			end
		else 
			flash.now[:danger] = 'Password lama tidak tepat'
			render 'index'
		end
	end

	private
		def account_params
			params.require(:user).permit(:password, :password_confirmation)
		end

	def require_authorization
		redirect_to root_path unless logged_in?[0]
	end
end
