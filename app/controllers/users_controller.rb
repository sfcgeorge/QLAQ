class UsersController < ApplicationController
  layout 'refinery/layouts/login'

  def forem_new
    @user = Refinery::User.new
  end

  def forem_create
    @user = Refinery::User.new(params[:user].except(:roles, :plugins))

    if @user.save
      flash[:message] = "<h2>#{t('welcome', :scope => 'refinery.users.create', :who => @user.username).gsub(/\.$/, '')}.</h2>".html_safe

      sign_in(@user)
      redirect_to forem.root_path
    else
      render :forem_new
    end
  end
end