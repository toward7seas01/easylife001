# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20091202031616) do

  create_table "admins", :force => true do |t|
    t.string   "area"
    t.text     "info"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["user_id"], :name => "index_admins_on_user_id"

  create_table "banners", :force => true do |t|
    t.integer  "size"
    t.integer  "width"
    t.integer  "height"
    t.integer  "user_id"
    t.string   "content_type"
    t.string   "filename"
    t.boolean  "conceal",      :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "banners", ["user_id"], :name => "index_banners_on_user_id"

  create_table "blog_tracks", :force => true do |t|
    t.integer "blog_id"
    t.integer "view_times", :default => 0
  end

  add_index "blog_tracks", ["blog_id"], :name => "index_blog_tracks_on_blog_id"

  create_table "blog_votes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "blog_id"
    t.integer  "info"
    t.boolean  "conceal",    :default => false
    t.datetime "created_at"
  end

  add_index "blog_votes", ["blog_id"], :name => "index_blog_votes_on_blog_id"
  add_index "blog_votes", ["user_id", "blog_id"], :name => "index_blog_votes_on_user_id_and_blog_id", :unique => true
  add_index "blog_votes", ["user_id"], :name => "index_blog_votes_on_user_id"

  create_table "blogs", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "user_id"
    t.boolean  "conceal",       :default => false
    t.integer  "remarks_count", :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "blogs", ["user_id"], :name => "index_blogs_on_user_id"

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.integer  "categorizations_count", :default => 0
    t.datetime "created_at"
  end

  add_index "categories", ["name"], :name => "index_categories_on_name"

  create_table "categorizations", :force => true do |t|
    t.integer  "blog_id"
    t.integer  "category_id"
    t.integer  "user_id"
    t.boolean  "conceal",     :default => false
    t.datetime "created_at"
  end

  add_index "categorizations", ["blog_id"], :name => "index_categorizations_on_blog_id"
  add_index "categorizations", ["category_id"], :name => "index_categorizations_on_category_id"
  add_index "categorizations", ["user_id"], :name => "index_categorizations_on_user_id"

  create_table "comments", :force => true do |t|
    t.integer  "topic_id"
    t.integer  "user_id"
    t.integer  "forum_id"
    t.text     "content"
    t.boolean  "conceal",    :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["forum_id"], :name => "index_comments_on_forum_id"
  add_index "comments", ["topic_id"], :name => "index_comments_on_topic_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "covers", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "thumbnail_id"
    t.integer  "user_id"
    t.boolean  "conceal",      :default => false
    t.integer  "images_count", :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "covers", ["user_id"], :name => "index_covers_on_user_id"

  create_table "feeds", :force => true do |t|
    t.integer  "forum_id"
    t.string   "name"
    t.integer  "user_id"
    t.string   "title"
    t.datetime "created_at"
  end

  create_table "forums", :force => true do |t|
    t.string  "title"
    t.string  "info"
    t.boolean "conceal",        :default => false
    t.integer "comments_count", :default => 0
    t.integer "topics_count",   :default => 0
  end

  create_table "images", :force => true do |t|
    t.integer  "parent_id"
    t.integer  "size"
    t.integer  "width"
    t.integer  "height"
    t.integer  "user_id"
    t.integer  "cover_id"
    t.string   "content_type"
    t.string   "filename"
    t.string   "thumbnail"
    t.string   "info"
    t.boolean  "conceal",      :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "images", ["cover_id"], :name => "index_images_on_cover_id"
  add_index "images", ["user_id"], :name => "index_images_on_user_id"

  create_table "msgs", :force => true do |t|
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at"
  end

  add_index "msgs", ["user_id"], :name => "index_msgs_on_user_id"

  create_table "profiles", :force => true do |t|
    t.integer  "size"
    t.integer  "width"
    t.integer  "height"
    t.integer  "user_id"
    t.string   "content_type"
    t.string   "filename"
    t.boolean  "conceal",      :default => false
    t.datetime "created_at"
  end

  add_index "profiles", ["user_id"], :name => "index_profiles_on_user_id"

  create_table "remarks", :force => true do |t|
    t.integer  "user_id"
    t.integer  "blog_id"
    t.text     "content"
    t.boolean  "conceal",    :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "remarks", ["blog_id"], :name => "index_remarks_on_blog_id"
  add_index "remarks", ["user_id"], :name => "index_remarks_on_user_id"

  create_table "results", :force => true do |t|
    t.integer  "user_id"
    t.integer  "follow_id"
    t.integer  "weight",     :default => 1
    t.integer  "sort",       :default => 0
    t.datetime "created_at"
  end

  add_index "results", ["follow_id"], :name => "index_results_on_follow_id"
  add_index "results", ["user_id"], :name => "index_results_on_user_id"

  create_table "simple_captcha_data", :force => true do |t|
    t.string   "key",        :limit => 40
    t.string   "value",      :limit => 6
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "topic_tracks", :force => true do |t|
    t.integer "topic_id"
    t.integer "view_times", :default => 0
  end

  add_index "topic_tracks", ["topic_id"], :name => "index_topic_tracks_on_topic_id"

  create_table "topics", :force => true do |t|
    t.string   "title"
    t.integer  "forum_id"
    t.integer  "user_id"
    t.integer  "view_times",       :default => 0
    t.integer  "kind",             :default => 0
    t.integer  "comments_count",   :default => 0
    t.integer  "first_comment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "topics", ["forum_id"], :name => "index_topics_on_forum_id"
  add_index "topics", ["user_id"], :name => "index_topics_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.text     "info"
    t.string   "from"
    t.string   "sex"
    t.string   "profession"
    t.string   "taste"
    t.string   "email"
    t.string   "hashed_password"
    t.string   "salt"
    t.integer  "comments_count",  :default => 0
    t.integer  "topics_count",    :default => 0
    t.integer  "view_times",      :default => 0
    t.integer  "blogs_count",     :default => 0
    t.boolean  "conceal",         :default => false
    t.string   "active_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
