class UsersController < ApplicationController
  before_action :authorize, :only => [:show, :edit, :update]

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

  # GET resource by id
  def show
  end

  # GET HTML for PUT/PATCH to #update
  def edit
  end

  # PATCH resource by id
  def update
    new_name = params[:name]
    new_phone = params[:phone]
    User.where(id: current_user.id).update_all(name: new_name, phone: new_phone)
    flash[:notice] = "User details updated."
    redirect_to user_path
  end


  private
  def user_params
    params.require(:user).permit(:username, :name, :email, :phone, :password, :password_confirmation)
  end
end
