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

ActiveRecord::Schema.define(version: 20190208134149) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "business_units", force: true do |t|
    t.integer  "organisation_id"
    t.string   "name",            limit: nil
    t.string   "sms_key",         limit: nil
    t.string   "sms_token",       limit: nil
    t.string   "sender_email",    limit: nil
    t.string   "sms_sender_id",   limit: nil
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "logo",            limit: nil
  end

  create_table "contacts", force: true do |t|
    t.integer  "outstanding_id"
    t.string   "email",          limit: nil
    t.string   "mobile",         limit: nil
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "images", force: true do |t|
    t.integer  "personnel_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "scan_file_name"
    t.string   "scan_content_type"
    t.integer  "scan_file_size"
    t.datetime "scan_updated_at"
  end

  create_table "organisations", force: true do |t|
    t.string   "name",       limit: nil
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "outstandings", force: true do |t|
    t.string   "customer",        limit: nil
    t.string   "invoice_number",  limit: nil
    t.datetime "invoice_date"
    t.decimal  "invoice_amount"
    t.decimal  "amount"
    t.text     "additional_info"
    t.integer  "credit_period"
    t.boolean  "ignore"
    t.boolean  "collected"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "personnels", force: true do |t|
    t.string   "email",                  limit: nil
    t.string   "name",                   limit: nil
    t.string   "passwordhash",           limit: nil
    t.string   "passwordsalt",           limit: nil
    t.string   "auth_token",             limit: nil
    t.string   "password_reset_token",   limit: nil
    t.datetime "password_reset_sent_at"
    t.string   "mobile",                 limit: nil
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "designation",            limit: nil
    t.integer  "business_unit_id"
  end

  create_table "reminders", force: true do |t|
    t.integer  "outstanding_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "templates", force: true do |t|
    t.integer  "overdue_from"
    t.integer  "overdue_to"
    t.text     "header"
    t.text     "footer"
    t.integer  "periodicity"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "day"
    t.datetime "time"
    t.integer  "day_2"
    t.datetime "time_2"
  end

end
