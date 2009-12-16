class CreateCategorizations < ActiveRecord::Migration
  def self.up
    create_table :categorizations do |t|
      t.integer :blog_id
      t.integer :category_id
      t.integer :user_id
      t.boolean :conceal, :default => false
      
      t.timestamp :created_at
    end

    add_index :categorizations, :user_id
    add_index :categorizations, :category_id
    add_index :categorizations, :blog_id

  end

  def self.down
    drop_table :categorizations
  end
end
