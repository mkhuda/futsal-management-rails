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

ActiveRecord::Schema.define(version: 20160129155846) do

  create_table "fields", force: :cascade do |t|
    t.string   "name",             limit: 255
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "jenis_rumput",     limit: 45
    t.string   "kondisi_lapangan", limit: 45
    t.text     "keterangan",       limit: 65535
    t.integer  "futsal_place_id",  limit: 4
  end

  add_index "fields", ["futsal_place_id"], name: "fk_fields_to_place1_idx", using: :btree

  create_table "futsal_places", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.text     "deskripsi",  limit: 65535
    t.string   "alamat",     limit: 255
    t.string   "kecamatan",  limit: 100
    t.decimal  "latitude",                 precision: 9, scale: 6
    t.decimal  "longitude",                precision: 9, scale: 6
    t.string   "phone",      limit: 45
    t.string   "email",      limit: 150
    t.integer  "user_id",    limit: 4
  end

  add_index "futsal_places", ["user_id"], name: "fk_futsal_places_1_idx", using: :btree

  create_table "orders", force: :cascade do |t|
    t.decimal  "biaya",                precision: 10
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "order_id",   limit: 4
    t.integer  "visitor_id", limit: 4
  end

  add_index "orders", ["visitor_id"], name: "index_orders_on_visitor_id", using: :btree

  create_table "prices", force: :cascade do |t|
    t.decimal  "harga",                       precision: 10
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.time     "jam_mulai"
    t.time     "jam_akhir"
    t.string   "hari",            limit: 100
    t.integer  "futsal_place_id", limit: 4
  end

  add_index "prices", ["futsal_place_id"], name: "fk_prices_to_place1_idx", using: :btree

  create_table "team_members", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "email",         limit: 150
    t.string   "phone",         limit: 50
    t.string   "alamat",        limit: 255
    t.string   "kecamatan",     limit: 100
    t.string   "member_status", limit: 20
  end

  create_table "usages", force: :cascade do |t|
    t.integer  "field_id",       limit: 4
    t.integer  "team_member_id", limit: 4
    t.datetime "start_date"
    t.datetime "finish_date"
    t.decimal  "harga",                    precision: 10
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  add_index "usages", ["field_id"], name: "index_usages_on_field_id", using: :btree
  add_index "usages", ["team_member_id"], name: "index_usages_on_team_member_id", using: :btree

  create_table "user_members", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "alamat",          limit: 255
    t.string   "team_position",   limit: 45
    t.string   "status",          limit: 20
    t.string   "phone",           limit: 100
    t.string   "email",           limit: 150
    t.string   "user_memberscol", limit: 45
    t.integer  "team_id",         limit: 4
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "password_digest", limit: 255
    t.string   "email",           limit: 100
    t.string   "remember_digest", limit: 255
  end

  add_index "users", ["email"], name: "email_UNIQUE", unique: true, using: :btree

  create_table "visitors", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_foreign_key "fields", "futsal_places", name: "fk_fields_to_place1"
  add_foreign_key "futsal_places", "users", name: "fk_futsal_places_1"
  add_foreign_key "orders", "visitors"
  add_foreign_key "prices", "futsal_places", name: "fk_prices_to_place1"
end
