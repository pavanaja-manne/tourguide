# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140218165724) do

  create_table "guides", :force => true do |t|
    t.string   "title"
    t.string   "tag_line"
    t.string   "city"
    t.integer  "stress_factor"
    t.string   "pacing"
    t.string   "category"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "user_id"
    t.boolean  "publish"
    t.float    "lat"
    t.float    "lng"
  end

  create_table "locations", :force => true do |t|
    t.string   "name"
    t.float    "long"
    t.float    "lat"
    t.string   "tag"
    t.string   "category"
    t.text     "why_i_like"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.integer  "guide_id"
    t.string   "foursquare_id"
    t.string   "foursquare_image_url"
    t.integer  "user_id"
    t.string   "address"
  end

  create_table "relationships", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "relationships", ["follower_id", "followed_id"], :name => "index_relationships_on_follower_id_and_followed_id", :unique => true

  create_table "users", :force => true do |t|
    t.string   "uid"
    t.string   "img"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "email"
    t.string   "location"
    t.text     "biography"
    t.string   "website"
    t.boolean  "follow"
    t.boolean  "comment"
  end

end
