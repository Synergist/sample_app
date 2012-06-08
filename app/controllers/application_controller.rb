class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  # include SslRequirement
  
  def ssl_required?
    true if USE_SSL
  end
  
  helper :all
  
end
