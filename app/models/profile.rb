class Profile < ProfileLike
  Alternate = first

  has_attachment :content_type => :image,
    :storage => :file_system

  Width = 130
  Height = 120
  
end

