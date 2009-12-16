class AdminsController < ApplicationController

  skip_filter :master?, :only => :show
  before_filter :convert_url, :only => :show

  def edit
    @user = User.find_admin(params[:id])
  end

  def create
    @user = User.new(params[:user])
    @user.name = params[:user][:name]
    
    if @user.save
      assign_admin_session(@user.admin)
      redirect_to(@user.admin)
    else
      render :action => "new"
    end
  end

  def update
    @user = User.first(:joins => :admin, :conditions => {:admins => {:id => params[:id]} }, :readonly => false)

    if @user.update_attributes(params[:user])
      redirect_to(@user.admin)
    else
      render :action => :edit
    end
  end

  private

  def convert_url
    if session[:a_area]
      @master = true
    else
      false_page
    end
  end

end

