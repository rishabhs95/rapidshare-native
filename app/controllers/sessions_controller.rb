class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_username(params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to '/'
      flash[:notice] = 'User logged in successfully'
    else
      redirect_to '/login'
      flash[:error] = 'Login credentials failed'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
    flash[:notice] = 'User logged out'
  end
end
