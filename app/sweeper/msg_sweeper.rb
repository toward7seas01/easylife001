class MsgSweeper < ActionController::Caching::Sweeper
  observe Msg

  def expire_cached_content(record)
    expire_page :controller => 'msgs', :action => 'index'
  end

  alias_method :after_save, :expire_cached_content
  alias_method :after_destroy, :expire_cached_content

end
