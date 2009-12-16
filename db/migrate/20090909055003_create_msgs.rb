class CreateMsgs < ActiveRecord::Migration
  def self.up
    create_table :msgs do |t|
      t.text :content
      t.integer :user_id

      t.timestamp :created_at
    end

    add_index :msgs, :user_id
  end

  def self.down
    drop_table :msgs
  end
end
