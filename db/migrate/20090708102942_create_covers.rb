class CreateCovers < ActiveRecord::Migration
  def self.up
    create_table :covers do |t|
      t.string :title
      t.text :content
      t.integer :thumbnail_id
      t.integer :user_id
      t.boolean :conceal, :default => false
      t.integer :images_count, :default => 0
  
      t.timestamps
    end

    add_index :covers, :user_id
  end

  def self.down
    drop_table :covers
  end
end
