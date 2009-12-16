class BlogSweeper < ActionController::Caching::Sweeper
  observe Blog

  def expire_cached_content(record)
    return unless params
    expire_page(user_show_path(params[:user_id], params[:page]))
    if params[:page] == 1
      expire_page(user_path(params[:user_id]))
    end
  end

  alias_method :after_save, :expire_cached_content
  alias_method :after_destroy, :expire_cached_content

end

