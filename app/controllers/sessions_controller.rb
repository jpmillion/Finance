class SessionsController < ApplicationController
  def login
    @user = User.new
  end
end
