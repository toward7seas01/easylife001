class Category < ActiveRecord::Base
  has_many :categorizations, :dependent => :destroy
  has_many :blogs, :through => :categorizations
#  has_many :users, :through => :categorizations

end
