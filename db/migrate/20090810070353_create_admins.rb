class CreateAdmins < ActiveRecord::Migration
  def self.up
    create_table :admins do |t|
      t.string :area
      t.text :info
      t.integer :user_id
     
      t.timestamps
    end

    add_index :admins, :user_id
  end

  def self.down
    drop_table :admins
  end
end
