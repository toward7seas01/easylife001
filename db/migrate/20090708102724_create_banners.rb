class CreateBanners < ActiveRecord::Migration
  def self.up
    create_table :banners do |t|
      t.integer :size
      t.integer :width
      t.integer :height
      t.integer :user_id
      t.string :content_type
      t.string :filename
      t.boolean :conceal, :default => false
      
      t.timestamps
    end

    add_index :banners, :user_id
  end

  def self.down
    drop_table :banners
  end
end
