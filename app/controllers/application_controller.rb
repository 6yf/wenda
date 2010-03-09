class ApplicationController < ActionController::Base
  #layout "mainlayout"
  
  protect_from_forgery

  def authenticate
    authenticate_or_request_with_http_basic do |user_name, password|
      user_name == "admin" && password == "rails"
    end
  end
end
