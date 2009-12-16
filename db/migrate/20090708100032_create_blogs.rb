class CreateBlogs < ActiveRecord::Migration
  def self.up
    create_table :blogs do |t|
      t.string :title
      t.text :content
      t.integer :user_id
      t.boolean :conceal, :default => false
      t.integer :remarks_count, :default => 0
      
      t.timestamps
    end

    add_index :blogs, :user_id
  end

  def self.down
    drop_table :blogs
  end
end
