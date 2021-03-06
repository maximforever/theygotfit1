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

ActiveRecord::Schema.define(version: 20151227234326) do

  create_table "feedbacks", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text     "comment"
  end

  create_table "quotes", force: :cascade do |t|
    t.string   "quote"
    t.string   "author"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "records", force: :cascade do |t|
    t.string   "photo"
    t.integer  "weight"
    t.boolean  "pounds"
    t.string   "caption"
    t.datetime "date"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "height"
    t.boolean  "inches"
    t.text     "other_photos"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "username"
    t.integer  "zipcode"
    t.boolean  "gender"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "age"
    t.string   "password_confirmation"
    t.string   "email"
    t.string   "password"
    t.string   "password_digest"
    t.boolean  "imperial"
    t.boolean  "email_confirmed",        default: false
    t.string   "confirm_token"
    t.string   "auth_token"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.text     "bio_do"
    t.text     "bio_eat"
    t.text     "bio_about"
  end

end
