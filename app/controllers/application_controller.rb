class ApplicationController < ActionController::Base
  before_filter :launch_redirect

  def forem_user
    current_refinery_user
  end
  helper_method :forem_user

  def after_sign_in_path_for(resource)
    '/forums'
  end

  protect_from_forgery

  private
  def launch_redirect
    redirect_to('/launch') and return unless Time.now > Time.new(2012,11,25,23) || (current_refinery_user && current_refinery_user.forem_admin) || request.env['PATH_INFO'] == '/refinery/login' || request.env['PATH_INFO'] == '/refinery/logout' || @just_signed_in
  end
end
