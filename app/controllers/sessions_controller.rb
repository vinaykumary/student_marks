class SessionsController < ApplicationController

  skip_before_filter :authorize
  def new
  end

  def create
    user=User.find_by_username(params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to session[:original_target], :notice => "Logged in!"
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/', :notice => "Logged out!"
  end
end
