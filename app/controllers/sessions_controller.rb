class SessionsController < ApplicationController

	def new

	end

	def create
		user = User.find_by_email(params[:session][:email])
		if user && user.authenticate(params[:session][:password])
			#sign in user and redirect to user's show page, sign_in is helper func
			flash[:success] = 'Sign in successful'
			sign_in user
			redirect_to user
		else
			#create error message and re-render signin form
			flash.now[:error] = 'Invalid email/password combination'
			render 'new'
		end
	end

	def destroy
		# call helper func from session helper module
		flash[:alert] = 'Log out successful'
		sign_out
		redirect_to root_path
	end
end
