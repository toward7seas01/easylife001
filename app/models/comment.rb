class Comment < ActiveRecord::Base
  
  with_options :counter_cache => true do |comment|
    comment.belongs_to :user
    comment.belongs_to :topic
    comment.belongs_to :forum
  end
  
  validates_length_of :content, :minimum => 20
  attr_accessible :content

  before_destroy :whether_or_not_destroy_related_topic

  def whether_or_not_destroy_related_topic
    topic.destroy if topic.comments.size == 1
  end

  def quote_format
    "<div class='quote'><b>#{user.name} 说</b><div class='quoteBody'>#{content}</div></div><br /><br />"
  end

  def self.special_new(params)
    comment = new(:content => params[:content])
    if params[:qid] and !params[:content]
      quote_comment = find(params[:qid])
      comment.content = quote_comment.quote_format
    end
    comment
  end

  
  def first_comment?
    self.id == topic.first_comment_id
  end

  def self.p_topics
    public.find(:all, :joins => {:topic => :topic_track}, :include => {:user => :profile}, :conditions => "comments.id = topics.first_comment_id", :order => "topic_tracks.view_times desc", :limit => Limit)
  end


end

