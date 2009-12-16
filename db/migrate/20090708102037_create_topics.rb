class CreateTopics < ActiveRecord::Migration
  def self.up
    create_table :topics do |t|
      t.string :title
      t.integer :forum_id
      t.integer :user_id
      t.integer :view_times, :default => 0
      t.integer :kind, :default => 0
      t.integer :comments_count, :default => 0
      t.integer :first_comment_id
      
      
      t.timestamps
    end

    add_index :topics, :forum_id
    add_index :topics, :user_id

  end

  def self.down
    drop_table :topics
  end
end
