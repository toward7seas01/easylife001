class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :name
      t.text :info
      t.string :from
      t.string :sex
      t.string :profession
      t.string :taste
      t.string :email
      t.string :hashed_password
      t.string :salt
      t.integer :comments_count, :default => 0
      t.integer :topics_count, :default => 0
      t.integer :view_times, :default => 0
      t.integer :blogs_count, :default => 0
      t.boolean :conceal, :default => false
      t.string :active_code

      t.timestamps
    end

  end

  def self.down
    drop_table :users
  end
end

