module CommentsHelper

  def topic_title_field
    hidden_field_tag(:title, @topic.title) if controller.controller_name == "topics"
  end

  def topic_or_comment_path(comment)
    if comment.first_comment?
      url = edit_forum_topic_path
    else
      url = edit_forum_topic_comment_path(:topic_id => params[:id], :id => comment.id)
    end
    link_to '编辑', url
  end
  
end
