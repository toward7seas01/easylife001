class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.string :name
      t.integer :categorizations_count, :default => 0

      t.timestamp :created_at
    end
    
    add_index :categories, :name
  end

  def self.down
    drop_table :categories
  end
end
