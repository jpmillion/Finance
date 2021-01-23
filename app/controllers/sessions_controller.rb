class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create
  
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

  def logout
    session.delete :user_id
    render :login
  end
end
