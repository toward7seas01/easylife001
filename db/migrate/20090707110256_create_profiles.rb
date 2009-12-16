class CreateProfiles < ActiveRecord::Migration
  def self.up
    create_table :profiles do |t|
      t.integer :size
      t.integer :width
      t.integer :height
      t.integer :user_id
      t.string :content_type
      t.string :filename
      t.boolean :conceal, :default => false
      
      t.timestamp :created_at
    end
    
    add_index :profiles, :user_id
  end

  def self.down
    drop_table :profiles
  end
end
