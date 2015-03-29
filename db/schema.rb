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

ActiveRecord::Schema.define(version: 20150329205406) do

  create_table "authors", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bugs", force: :cascade do |t|
    t.string   "cr_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "commits", force: :cascade do |t|
    t.string   "commit_hash"
    t.text     "message"
    t.datetime "committed_at", null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "bug_id"
    t.integer  "author_id"
  end

  add_index "commits", ["author_id"], name: "index_commits_on_author_id"
  add_index "commits", ["bug_id"], name: "index_commits_on_bug_id"

end
