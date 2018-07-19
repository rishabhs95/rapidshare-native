class UsersController < ApplicationController
  def new
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to '/'
      flash[:notice] = 'User signed up successfully'
    else
      redirect_to '/signup'
      flash[:notice] = 'Error in signing up'
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :name, :email, :phone, :password, :password_confirmation)
  end
end
