class SessionsController < ApplicationController
  skip_before_action :login_required, only: [:login, :create]
  
  def login
    @user = User.new
  end

  def create
    if auth
      github_login
    else
      app_login
    end
  end

  def destroy
    session.clear
    redirect_to root_path, notice: "Successfully Logged Out"
  end

  private 
  
  def auth
    request.env['omniauth.auth']
  end

  def github_login
    @customer = Customer.find_or_create_by(email: auth['info']['email']) do |u|
      u.password = SecureRandom.hex(12)
    end
    if @customer
      session[:user_id] = @customer.id
      redirect_to @customer, notice: 'Successfully Logged In with github'
    else
      redirect_to login_path, alert: 'Unable to log in with github'
    end
  end

  def app_login
    @user = User.find_by(username: params[:user][:username])
    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect_to customer_path(@user), notice: "Successfully Logged In"
    else
      redirect_to login_path, alert: "Invalid username or password"
    end
  end

end
