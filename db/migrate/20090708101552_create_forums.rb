class CreateForums < ActiveRecord::Migration
  def self.up
    create_table :forums do |t|
      t.string :title
      t.string :info
      t.boolean :conceal, :default => false
      t.integer :comments_count, :default => 0
      t.integer :topics_count, :default => 0
      
    end

  end

  def self.down
    drop_table :forums
  end
end

