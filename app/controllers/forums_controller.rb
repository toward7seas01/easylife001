class ForumsController < ApplicationController
  
  before_filter :generate_model, :only => [:show, :show_concealed_topics, :aconceal, :aunconceal]  
  caches_page :index, :show, :unless => :judge_admin_path?
  cache_sweeper :forum_sweeper, :only => [:create, :update, :destroy, :aconceal, :aunconceal]

  def index
    @forums = Forum.public
    @concealed_forums = Forum.concealed if @master
  end

  def show
    @topics = @forum.public_topics(params[:page])
  end

  def show_concealed_topics
    @topics = @forum.concealed_topics(params[:page])
    render :template => 'forums/show.html.erb'
  end

  add_methods(:aconceal, :aunconceal) do
    @forum.send(__method__)
    redirect_to(admin_forums_url)
  end

end

