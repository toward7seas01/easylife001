class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.integer :topic_id
      t.integer :user_id
      t.integer :forum_id
      t.text :content
      t.boolean :conceal, :default => false
      
      t.timestamps
    end

    add_index :comments, :user_id
    add_index :comments, :forum_id
    add_index :comments, :topic_id

  end

  def self.down
    drop_table :comments
  end
end
