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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140723130000) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "images", force: true do |t|
    t.string   "original_id"
    t.string   "user_id"
    t.string   "url"
    t.boolean  "presented",   default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "likes",       default: 0
    t.integer  "wall_id"
    t.string   "status",      default: "pending_approval"
  end

  add_index "images", ["wall_id"], name: "index_images_on_wall_id", using: :btree

  create_table "sessions", force: true do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "wall_roles", force: true do |t|
    t.integer  "user_id"
    t.integer  "wall_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "wall_roles", ["user_id"], name: "index_wall_roles_on_user_id", using: :btree
  add_index "wall_roles", ["wall_id"], name: "index_wall_roles_on_wall_id", using: :btree

  create_table "walls", force: true do |t|
    t.string   "name"
    t.string   "instagram_hashtag"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "background_image_file_name"
    t.string   "background_image_content_type"
    t.integer  "background_image_file_size"
    t.datetime "background_image_updated_at"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.string   "background_style",              default: "center"
    t.boolean  "require_image_approval",        default: false
  end

end
