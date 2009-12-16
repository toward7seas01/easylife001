class MsgsController < ApplicationController

  before_filter :prepare_for_indexs, :only => [:index, :admin_index]
  caches_page :index
  cache_sweeper :msg_sweeper, :only => [:create, :destroy]

  
  def create
    if session[:user_id]
      msg = Msg.new(params[:msg])
      msg.user_id = session[:user_id]
      msg.save
    end
    render_nothing
  end

  def destroy
    super do |format|
      format.js { delete_dom }
    end
  end

  def index   
    render @msgs
  end

  private

  def prepare_for_indexs
    @msgs = Msg.index
  end

end

