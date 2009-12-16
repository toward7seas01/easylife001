class Cover < ActiveRecord::Base
  has_many :images, :dependent => :destroy
  belongs_to :thumbnail, :class_name => 'Image', :foreign_key => 'thumbnail_id'
  belongs_to :user
  
  attr_accessible :title, :content, :thumbnail_id
  validates_presence_of :title

end

