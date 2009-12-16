class Topic < ActiveRecord::Base
  with_options :counter_cache => true do |topic|
    topic.belongs_to :forum
    topic.belongs_to :user
  end
  has_one :topic_track, :dependent => :destroy
  has_many :comments
  accepts_nested_attributes_for :comments

  attr_accessor :register_comment
  attr_accessible :title, :comments_attributes
   
  validates_length_of :title, :in => 5..30
  Kind = ["普通","良好","精华","隐藏",'置顶']

  def after_create
    self.first_comment_id = comments.first.id
    save
  end

  def after_new(params, session)
    self.user_id, self.forum_id = session[:user_id], params[:forum_id]
    comment = self.comments.first
    comment.user_id, comment.forum_id = session[:user_id], params[:forum_id]
  end

  def self.user_id(id)
    connection.select_value(ok_sql(["select user_id from topics where id = ?", id]))
  end

  def before_create
    build_topic_track
  end

  def prepare_for_edit(params)
    self.title = params[:title] if params[:title]
    comment = comments.first
    comment.content = params[:content] if params[:content]
    self.register(comment)
  end

  def register(comment)
    self.register_comment = comment
    class << self
      def comments
        [register_comment]
      end
    end
  end
  

end

