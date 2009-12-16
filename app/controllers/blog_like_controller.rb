class BlogLikeController <  ApplicationController
  layout "users"

  before_filter :current_space, :except => [:conceal, :unconceal]
  before_filter :authentic, :only => [:new, :edit, :create, :update, :destroy]
  helper_method :page_user_id, :page_user

  private

  def authentic    
    false_page unless session[:user_id] == page_user_id
  end

  def current_space
    @current_banner = page_user.banner
    @current_categories = Category.find_by_sql(["select c.id, c.name, count(cn.blog_id) as blogs_count from categorizations cn, categories c where cn.user_id = ? and c.id = cn.category_id group by cn.category_id order by blogs_count", page_user_id])
    @current_blogs_size = page_user.blogs.size
  end

  def page_user_id
    @page_user_id ||= (params[:user_id] ? params[:user_id] : params[:id]).to_i
  end

  def page_user
    @page_user ||= User.find page_user_id
  end
  




end

