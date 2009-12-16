module ForumsHelper

  def show_concealed_or_public_topics
    if params[:action] == "show"
      l_a '查看隐藏主题', show_concealed_topics_admin_forum_path
    else
      l_a '查看公共主题', admin_forum_path
    end
  end

end
