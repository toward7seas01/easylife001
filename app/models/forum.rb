class Forum < ActiveRecord::Base
  has_many :topics
  has_many :comments
  validates_presence_of :title

  Perpage = 20
  Order_conditions = " order by created_at desc"

  def public_topics(page)
    top_topic_sql = base_sql("= 4")
    other_topic_sql = base_sql("<> 3")
    Topic.paginate_by_sql(" #{top_topic_sql} union #{other_topic_sql}" + Order_conditions, :page => page)
  end

  def concealed_topics(page)
    Topic.paginate_by_sql(base_sql("= 3") + Order_conditions, :page => page)
  end

  def base_sql(kind_condition)
    <<-SQL
      (select t.*, u.name, tt.view_times, concat(a.name, "<br />", c.updated_at) as last_user from topics t, users u, topic_tracks tt, users as a, comments c where t.kind #{kind_condition} and t.forum_id = #{id} and t.user_id = u.id and t.id = tt.topic_id and c.id = (select comments.id from comments where comments.topic_id = t.id order by comments.id desc limit 1) and c.user_id = a.id order by t.id desc)
    SQL
  end

  class << self
    
    add_methods(:public, :concealed) do
      find_by_sql <<-SQL
        select f.*, concat(u.name, "<br />", c.updated_at) as last_user from forums f, users u, comments c where c.id = (select comments.id from comments where comments.forum_id = f.id order by comments.id desc limit 1) and c.user_id = u.id and f.conceal = #{ (__method__ == :public ) ? 0 : 1 } order by f.id
      SQL
    end

  end

end

