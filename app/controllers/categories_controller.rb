class CategoriesController < BlogLikeController

  skip_filter :current_space, :authentic, :except => :show

  def show
    @category = Category.find params[:id]
    @blogs = Blog.paginate_all_by_user_id(params[:user_id], :joins => :categories, :conditions => "categories.id = #{@category.id}", :page => params[:page])
  end

  def index
    @categories = Category.paginate(:all, :page => params[:page])
    render "index", :layout => "application"
  end

  def destroy
    super do |format|
      format.js { delete_dom }
    end
  end

end
