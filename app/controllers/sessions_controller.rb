class SessionsController < ApplicationController
	 def new
  end

  def create
  personnel = Personnel.authenticate(params[:email], params[:password])
  if personnel
   
    if params[:remember_me]
      cookies.permanent[:auth_token] = personnel.auth_token
    else
      cookies[:auth_token] = personnel.auth_token  
    end
    
	redirect_to :back
  else
    flash.now.alert = "Invalid email or password"
    render "new"
  end
end

def destroy
 cookies.delete(:auth_token)
  redirect_to sessions_new_url
end
  
end
