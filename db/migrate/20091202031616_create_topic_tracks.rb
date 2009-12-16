class CreateTopicTracks < ActiveRecord::Migration
  def self.up
    create_table :topic_tracks do |t|
      t.integer :topic_id
      t.integer :view_times, :default => 0

    end

    add_index :topic_tracks, :topic_id
  end

  def self.down
    drop_table :topic_tracks
  end
end
