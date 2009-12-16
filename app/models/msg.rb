class Msg < ActiveRecord::Base
  belongs_to :user
  attr_accessible :content

  named_scope :index, :order => "created_at desc", :limit => 15, :include => :user
  
end

