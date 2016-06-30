class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

   #http_basic_authenticate_with ENV['CHECKFRONT_CLIENT_KEY'], ENV['CHECKFRONT_CLIENT_SECRET'], except: :index
  
end
