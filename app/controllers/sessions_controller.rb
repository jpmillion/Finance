class SessionsController < ApplicationController
  skip_before_action :login_required, only: [:login, :create]
  
  def login
    @user = User.new
  end

  def create
    @user = User.find_by(username: params[:user][:username])
    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect_to user_path(@user), alert: "Successfully Logged In"
      #render :'users/show'
    else
      redirect_to login_path, alert: "Invalid username or password"
    end
  end

  def destroy
    session.clear
    redirect_to login_path, alert: "Successfully Logged Out"
  end
end
