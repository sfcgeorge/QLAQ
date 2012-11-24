class ApplicationController < ActionController::Base
  before_filter :launch_redirect

  def forem_user
    current_refinery_user
  end
  helper_method :forem_user

  protect_from_forgery

  private
  def launch_redirect
    redirect_to('/launch') and return unless (current_refinery_user && current_refinery_user.forem_admin) || request.env['PATH_INFO'] == '/refinery/login' || request.env['PATH_INFO'] == '/refinery/logout' # Time.now > future
  end
end
