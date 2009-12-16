class TopicsController < ApplicationController
  
  cache_sweeper :forum_sweeper, :only => [:create, :update]
  before_filter :generate_model, :only => [:edit, :update, :ajax_update ]
  before_filter :ownership?, :only => :update
  before_filter :keep_track, :only => :show


  def show
    @comments = @topic.comments.paginate(:all, :page => params[:page], :include => [:topic, {:user => :profile}])
  end


  def new
    @topic = Topic.new(:title => params[:title])
    @topic.comments.build(:content => params[:content])
    render_new_or_edit
  end

  def create
    @topic = Topic.new(params[:topic])
    @topic.after_new(params, session)

    return if need_preview?   
    when_save
  end

  def edit
    @topic.prepare_for_edit(params)
    render_new_or_edit
  end

  def update
    @topic.attributes = params[:topic]
    return if need_preview?

    when_save
  end
  
  def ajax_update
    @topic.update_attribute(:kind, params[:kind])

    render_nothing
  end

  private
  
  def keep_track
    @topic = Topic.find(params[:id])
    false_page and return if @topic.kind == 3
    @topic.topic_track.increment!(:view_times)
    keep_track_by_weight(View_topic_weight, @topic.user_id)
  end
  
  def when_save
    if @topic.save
      redirect_to forum_topic_path(params[:forum_id], @topic.id)
    else
      @topic.register(@topic.comments.first) if action_name == "update"
      render_new_or_edit
    end
  end
   

end

