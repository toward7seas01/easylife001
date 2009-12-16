class SearchController < ApplicationController

  def index
    send("#{params[:type]}_search") if params[:type]
  end

  def blog_search
    @blogs = Blog.public.paginate(:all, :conditions => ["(content regexp ? or title regexp ?) ", handle_query_params, handle_query_params], :page => params[:page])
    render_results(@blogs)
  end

  def comment_search
    @comments = Comment.public.paginate(:all, :conditions => ["content regexp ? ", handle_query_params], :page => params[:page])
    render_results(@comments)
  end

  def user_search
    @users = User.public.paginate(:all, :conditions => ["name regexp ? ", handle_query_params], :page => params[:page])
    render_results(@users)
  end

  private

  def handle_query_params
    @handle_query_params ||= handle_input.join("|")
  end

  def handle_input
    @keys ||= Blog.handle_input(params[:s])
  end

  def render_results(results)
    render :partial => "results", :object => results, :layout => true
  end

end

