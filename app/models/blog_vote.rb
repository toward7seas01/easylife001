class BlogVote < ActiveRecord::Base
  belongs_to :blog
  belongs_to :user

  named_scope :vote, lambda{ |user_id, blog_id| {:joins => [:blog, :user], :conditions => {:blog_votes => {:user_id => user_id, :blog_id => blog_id} }, :limit => 1 }}

  def self.voted?(user_id, blog_id)
    vote(user_id, blog_id).blank?
  end
  
end
