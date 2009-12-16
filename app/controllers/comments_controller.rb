class CommentsController < ApplicationController
  cache_sweeper :forum_sweeper, :only => [:create, :update, :destroy]
  before_filter :generate_model, :only => [:show, :edit, :update, :destroy]
  before_filter :ownership?, :only => [:update, :destroy]

  def new
    @comment = Comment.special_new(params)
    render_new_or_edit
  end

  def show
    render :text => @comment.content
  end


  def edit
    @comment.content = params[:content] if params[:content]
    render_new_or_edit
  end

  def create
    @comment = Comment.new(params[:comment])
    @comment.after_new(params, session)
    return if need_preview?

    when_save { keep_track_by_weight(Comment_topic_weight, Topic.user_id(params[:topic_id])) }
  end

  def update
    @comment.attributes = params[:comment]
    return if need_preview?

    when_save
  end

  def destroy
    @comment.destroy
    redirect_to forum_url(:id => params[:forum_id])
  end

  private

  def when_save
    if @comment.save
      yield if block_given?
      redirect_to forum_topic_path(:id => params[:topic_id])
    else
      render_new_or_edit
    end
  end


  
end

