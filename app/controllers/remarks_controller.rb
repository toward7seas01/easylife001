class RemarksController < ApplicationController

  before_filter :ownership?, :only => [:update, :destroy]

  def new
    super do |format|
      format.js do render :partial => "new" end
    end
  end

  def show
    super do |format|
      format.html { render :text => @remark.content }
    end
  end

  def create
    super do |format|
      keep_track_by_weight(Remark_blog_weight, params[:user_id])
    end
  end

  def destroy
    super do |format|
      generate_model.special_assign(params)
    end
  end

end
