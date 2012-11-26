class ApplicationController < ActionController::Base
  def forem_user
    current_refinery_user
  end
  helper_method :forem_user

  def after_sign_in_path_for(resource)
    '/forums'
  end

  protect_from_forgery
end
