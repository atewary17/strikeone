class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
   helper_method :current_personnel


private

def current_personnel
  @current_personnel ||= Personnel.find_by_auth_token( cookies[:auth_token]) if cookies[:auth_token]
end


end
