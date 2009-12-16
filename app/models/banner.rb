class Banner < ProfileLike

  has_attachment :content_type => :image,
    :storage => :file_system

  Width = 620
  Height = 250

end

