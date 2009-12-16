class CreateBlogVotes < ActiveRecord::Migration
  def self.up
    create_table :blog_votes do |t|
      t.integer :user_id
      t.integer :blog_id
      t.integer :info
      t.boolean :conceal, :default => false
      
      t.timestamp :created_at
    end

    add_index :blog_votes, :user_id
    add_index :blog_votes, :blog_id
    add_index :blog_votes, [:user_id, :blog_id], :unique => true
  end

  def self.down
    drop_table :blog_votes
  end
end
