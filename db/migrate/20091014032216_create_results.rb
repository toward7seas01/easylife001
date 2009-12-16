class CreateResults < ActiveRecord::Migration
  def self.up
    create_table :results do |t|
      t.integer :user_id
      t.integer :follow_id
      t.integer :weight, :default => 1
      t.integer :sort, :default => 0

      t.timestamp :created_at
    end

    add_index :results, :user_id
    add_index :results, :follow_id
  end

  def self.down
    drop_table :results
  end
end
