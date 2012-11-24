class ApplicationController < ActionController::Base
  before_filter :launch_redirect

  def forem_user
    current_refinery_user
  end
  helper_method :forem_user

  protect_from_forgery

  private
  def launch_redirect
    redirect_to(root_path) and return unless 1 == 0 # Time.now == future
  end
end
