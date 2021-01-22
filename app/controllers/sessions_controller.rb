class SessionsController < ApplicationController
  def login
    @user = User.new
  end

  def create
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to user_path(@user)
      #render :'users/show'
    else
      render :login
    end
  end

  def destroy
    session.clear
    render :login
  end
end
