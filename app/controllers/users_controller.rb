class UsersController < ApplicationController
  # calls private methods of this controller, ensures authorization
  before_filter :signed_in_user, only: [:edit, :update, :index, :destroy]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user, only: [:destroy]

  def new
  	@user = User.new
  end

  def show
  	@user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def create
  	@user = User.new(params[:user])
  	if @user.save
  		# successful save
      sign_in @user # using helper function from session helper
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
  	else
  		render 'new'
  	end
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user]) # this returns false if the update fails
      # successful update
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_path # redirect to the users index
  end

  private

    def signed_in_user
      # uses shortcut to assigning flash[:notice]
      unless signed_in?
        store_location
        redirect_to signin_path, notice: "Please sign in."
      end
    end

    def correct_user
      # finds the user requested in the URL
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user) # calls session helper method to compare user in session to @user
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
