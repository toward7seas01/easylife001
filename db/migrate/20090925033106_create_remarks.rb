class CreateRemarks < ActiveRecord::Migration
  def self.up
    create_table :remarks do |t|
      t.integer :user_id
      t.integer :blog_id
      t.text :content
      t.boolean :conceal, :default => false

      t.timestamps
    end

    add_index :remarks, :user_id
    add_index :remarks, :blog_id
  end

  def self.down
    drop_table :remarks
  end
end
