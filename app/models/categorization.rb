class Categorization < ActiveRecord::Base
  belongs_to :category, :counter_cache => true
  belongs_to :blog
  belongs_to :user
end
