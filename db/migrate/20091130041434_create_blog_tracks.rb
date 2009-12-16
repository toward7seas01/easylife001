class CreateBlogTracks < ActiveRecord::Migration
  def self.up
    create_table :blog_tracks do |t|
      t.integer :blog_id
      t.integer :view_times, :default => 0

    end

    add_index :blog_tracks, :blog_id
  end

  def self.down
    drop_table :blog_tracks
  end
end
