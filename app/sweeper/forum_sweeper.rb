class ForumSweeper < ActionController::Caching::Sweeper
  observe Forum, Comment

  def expire_cached_content(record)
    expire_page( "/forums" )
    if record.is_a? Comment
      expire_page( "/forums/#{record.forum_id}" )
    else
      expire_page( "/forums/#{record.id}" )
    end
  end

  alias_method :after_save, :expire_cached_content
  alias_method :after_destroy, :expire_cached_content

end

