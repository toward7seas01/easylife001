class Result < ActiveRecord::Base
  belongs_to :user
  belongs_to :follower, :foreign_key => "follow_id", :class_name => "User"
  named_scope :auto_follow, :conditions => {:sort => 0}


  class << self

    def auto(owner_id)
      by_sort(owner_id, 0)
    end

    def human(owner_id)
      by_sort(owner_id, 1)
    end

    def generate_human_follow(user_id, following_name)
      follow_id = connection.select_value(ok_sql(["select id from users where name = ? ", following_name])).to_i
      Result.create_human_follow(user_id, follow_id)
      if result = Result.exist_auto_follow?(user_id, follow_id)
        result.destroy
      end
      follow_id
    end

    protected

    def create_human_follow(user_id, follow_id)
      find_or_create_by_user_id_and_follow_id_and_sort(user_id, follow_id, 1)
    end

    def exist_auto_follow?(user_id, follow_id)
      find_by_user_id_and_follow_id_and_sort(user_id, follow_id, 0)
    end

    private

    def by_sort(owner_id, sort)
      find_by_sql("select r.*, u.name from results r, users u where r.user_id = #{owner_id} and r.sort = #{sort} and r.follow_id = u.id order by r.weight")
    end

  end

end
