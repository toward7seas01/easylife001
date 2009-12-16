class Image < ActiveRecord::Base
  belongs_to :user
  belongs_to :cover, :counter_cache => true
  has_attachment :content_type => :image,
    :storage => :file_system,
    :thumbnails => { :thumb => '120x120>' }
  attr_protected :user_id, :cover_id, :conceal
  
  def self_path
    @self_path ||= "/users/#{self.user_id}/covers/#{self.cover_id}"
  end

end
