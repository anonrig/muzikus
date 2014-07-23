class SessionsController < ApplicationController
	
  def create
  	user = Users.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to mail_url
  end

  def destroy
  	session[:user_id] = nil
    redirect_to root_url
  end
end
