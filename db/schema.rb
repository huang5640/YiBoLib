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

ActiveRecord::Schema.define(version: 20160125194135) do

  create_table "books", force: :cascade do |t|
    t.string   "title"
    t.string   "author"
    t.string   "description"
    t.string   "ISBN"
    t.string   "image"
    t.string   "YiBoNum"
    t.string   "keywords"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "location_id"
  end

  create_table "books_checkings", force: :cascade do |t|
    t.integer "book_id"
    t.integer "checking_id"
  end

  create_table "checkings", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.string   "status"
  end

  create_table "locations", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.string   "phone"
    t.string   "manager"
    t.string   "open_at"
    t.string   "close_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "managers", force: :cascade do |t|
    t.string   "YiBoID"
    t.string   "authorization"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "GovID"
    t.string   "address"
    t.integer  "AuthNum"
    t.string   "YiBoID"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
    t.string   "userType"
    t.string   "email"
  end

end
