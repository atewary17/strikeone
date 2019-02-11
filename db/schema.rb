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

ActiveRecord::Schema.define(version: 20190211103113) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "images", force: :cascade do |t|
    t.integer  "personnel_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "scan_file_name"
    t.string   "scan_content_type"
    t.integer  "scan_file_size",    limit: 8
    t.datetime "scan_updated_at"
    t.boolean  "processed"
  end

  create_table "labels", force: :cascade do |t|
    t.string   "description"
    t.decimal  "score"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "image_id"
    t.string   "identification_code"
  end

  create_table "personnels", force: :cascade do |t|
    t.string   "email"
    t.string   "name"
    t.string   "passwordhash"
    t.string   "passwordsalt"
    t.string   "auth_token"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.string   "mobile"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "web_entities", force: :cascade do |t|
    t.string   "description"
    t.decimal  "score"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "image_id"
    t.string   "identification_code"
  end

end
