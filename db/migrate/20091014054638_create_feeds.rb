class CreateFeeds < ActiveRecord::Migration
  def self.up
    create_table :feeds do |t|
      t.integer :forum_id
      t.string :name
      t.integer :user_id
      t.string :title

      t.timestamp :created_at
    end
  end

  def self.down
    drop_table :feeds
  end
end
