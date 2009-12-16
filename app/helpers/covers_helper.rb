module CoversHelper
  
  def cover_thumbnail(cover)
    (thumbnail = cover.thumbnail) ? thumb_image(thumbnail) : "还没有设置封面"
  end

end
