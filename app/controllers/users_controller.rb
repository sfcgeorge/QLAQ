class UsersController < ApplicationController
  layout 'refinery/layouts/login'

  before_filter :redirect_if_logged_out, :only => [:edit, :update]

  def show
    @user = Refinery::User.find_by_id(params[:id]) ||
            Refinery::User.find_by_username(params[:id]) ||
            Refinery::User.new({ username: '*Nobody' })
    @title = "#{@user.username}'s profile"
    render :layout => 'application'
  end

  def new
    @user = Refinery::User.new
  end

  def create
    @user = Refinery::User.new(params[:user].except(:roles, :plugins))

    if @user.save
      flash[:message] = "<h2>#{t('welcome', :scope => 'refinery.users.create', :who => @user.username).gsub(/\.$/, '')}.</h2>".html_safe

      sign_in(@user)
      redirect_to forem.root_path
    else
      render :new
    end
  end

  def edit
    @user = current_refinery_user
  end

  def update
    @user = current_refinery_user

    params[:user].except!(:roles, :plugins, :birthday, :secret_code)

    if params[:user][:password].blank? and params[:user][:password_confirmation].blank?
      params[:user].except!(:password, :password_confirmation)
    end

    if @user.update_attributes(params[:user])
      redirect_to forem.root_path,
                  :notice => t('updated', :what => @user.username, :scope => 'refinery.crudify')
    else
      render :edit
    end
  end

  private
  def redirect_if_logged_out
    redirect_to refinery.new_refinery_user_session_path unless current_refinery_user
    redirect_to main_app.refinery_path unless current_refinery_user.id == params[:id].to_i
  end
end