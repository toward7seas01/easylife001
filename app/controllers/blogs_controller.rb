class BlogsController < BlogLikeController

  cache_sweeper :blog_sweeper, :only => [:create, :update, :destroy]
  skip_filter :current_space, :only => [:total, :ajax_check, :ajax_vote_up, :ajax_vote_down, :destroy]
  before_filter :not_voted?, :only => [:ajax_vote_up, :ajax_vote_down]
  before_filter :keep_track, :only => :show
  before_filter :generate_model, :only => [:show, :ajax_vote_up, :ajax_vote_down]

  Popular_kind = ["生活", "ruby", "rails", "jquery"]

  def index
    @blogs = Blog.show_all(params)
  end
  
  def total
    @blogs = Blog.list_by_limit(Limit)
    @remarks = Remark.list_by_limit(Limit).scoped(:include => [:user, :blog])
    @popular_blogs = ActiveSupport::OrderedHash.new
    Popular_kind.each do |kind| @popular_blogs[kind] = Blog.show_blogs_by_category(kind, Limit) end
    render "total", :layout => "application"
  end

  def show
    @remarks = @blog.remarks.paginate(:all, :include => :user, :page => params[:page])
    @vote_kind = @blog.blog_votes.count(:group => :info)
    @vote_kind.reverse_merge!({1 => 0, -1 => 0})
  end

  def ajax_check
    if session[:user_id] and BlogVote.voted?(session[:user_id], params[:id])
      render :text => "true"
    else
      render_nothing
    end
  end

  def ajax_vote_up
    ajax_vote(1)
  end

  def ajax_vote_down
    ajax_vote(-1)
  end

  private

  def ajax_vote(kind)
    @blog.blog_votes.create(:user_id => session[:user_id], :info => kind)
    @vote_kind, @votes_size = kind, @blog.blog_votes.count(:conditions => "blog_votes.info = #{kind}")
    render "ajax_vote.js"
  end

  def not_voted?
    unless session[:user_id] and BlogVote.voted?(session[:user_id], params[:id])
      render_nothing
    end
  end

  def keep_track
    blog_track = BlogTrack.find_by_blog_id(params[:id])
    blog_track.increment!(:view_times)
    keep_track_by_weight(View_blog_weight, params[:user_id])
  end


end

