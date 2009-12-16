module ImagesHelper
  def with_options
    "'ids=' + $.map($('#trash img'), function(node){ $(node.parentNode).addClass('destroy'); return(node.alt) })"
  end

  def return_to_cover
    link_to "返回", user_cover_path(:id => params[:cover_id])
  end
end
