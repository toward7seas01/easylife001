class CreateImages < ActiveRecord::Migration
  def self.up
    create_table :images do |t|
      t.integer :parent_id
      t.integer :size
      t.integer :width
      t.integer :height
      t.integer :user_id
      t.integer :cover_id
      t.string :content_type
      t.string :filename
      t.string :thumbnail
      t.string :info
      t.boolean :conceal, :default => false
      
      t.timestamps
    end

    add_index :images, :user_id
    add_index :images, :cover_id
  end

  def self.down
    drop_table :images
  end
end
