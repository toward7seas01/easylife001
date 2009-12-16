module TopicsHelper
  
  def title_or_link
    case
    when @topic.new_record?
      h(@topic.title)
    when controller.controller_name == "topics"
      link_to h(@topic.title), forum_topic_path
    else
      link_to h(@topic.title), forum_topic_path(:id => params[:topic_id])
    end
  end

  def back_preview_path
    if controller.controller_name == "topics"
      if @topic.new_record?
        new_forum_topic_path
      else
        edit_forum_topic_path
      end
    else
      if @comment.new_record?
        new_forum_topic_comment_path
      else
        edit_forum_topic_comment_path
      end
    end
  end
  
end
