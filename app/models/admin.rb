class Admin < ActiveRecord::Base

  belongs_to :user
  validates_presence_of :area
  delegate :name, :hashed_password, :salt, :password, :to => :user
  attr_accessible :area, :info

  def self.find_by_name(name)
    first(:include => :user, :conditions => {:users => {:name => name}})
  end
  
end

