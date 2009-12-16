class SessionsController < ApplicationController

  before_filter :reset_session, :only => [:create, :destroy]
  skip_filter :master?, :session_exist?

  caches_action :stats, :unless => :u?
  caches_page :new
  
  def new
    render_new_dialog
  end
  
  def create
    @user = User.find_by_name(params[:name])
    if is_self?(@user, params[:password])
      if @user.activated?
        assign_user_session(@user)
        reload_page
      else
        render_after_register
      end
    else
      render :update do |page|
        page.replace_html "error_message", "用户名或密码错误"
      end
    end
  end

  def stats
    if u?
      render_stats_content
    else
      render_nothing
    end
  end

  def destroy
    reload_page
  end

  private

  def render_stats_content
    options = [:user_id, :user_name]
    (options << :a_area) if session[:a_area]
    render :text => session.to_hash.to_json(:only => options)
  end



end

