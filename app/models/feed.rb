class Feed < ActiveRecord::Base
  
  class << self
    
    def how_is_following(user_id, page)   
      find_blogs_sql = base_sql("blogs")
      find_topics_sql = base_sql("topics")
      paginate_by_sql(["(#{ find_blogs_sql }) union all (#{ find_topics_sql}) order by time_line desc", user_id, user_id], :page => page)
    end

    private
    
    def forum_id_or_null(table_names)
      (table_names.classify.constantize.column_names.include? "forum_id") ? "#{table_names}.forum_id" : "null as forum_id"
    end

    def base_sql(table_names)
      "select #{table_names}.id, #{table_names}.title, #{table_names}.user_id, u.name, #{forum_id_or_null(table_names)}, #{table_names}.created_at as time_line from #{table_names}, users u where u.id = #{table_names}.user_id and u.id in (?)"
    end
    
  end
end
