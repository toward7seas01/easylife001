class Admin::SessionsController < ApplicationController

  before_filter :reset_session, :only => [:create, :destroy]
  skip_filter :master?, :session_exist?

  def new 
  end

  def create
    @admin = Admin.find_by_name(params[:name])
    if is_self?(@admin, params[:password])
      assign_admin_session(@admin)
      redirect_to admin_path(@admin)
    else
      flash[:notice] = "用户名或密码错误"
      render 'new'
    end
  end

  def destroy
    redirect_to new_admin_sessions_path
  end



end
