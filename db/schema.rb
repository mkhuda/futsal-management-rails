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

ActiveRecord::Schema.define(version: 20160405035835) do

  create_table "bookings", force: :cascade do |t|
    t.integer  "lapangan",        limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.time     "jam_mulai"
    t.time     "jam_akhir"
    t.date     "hari"
    t.integer  "futsal_place_id", limit: 4
  end

  add_index "bookings", ["futsal_place_id"], name: "fk_bookings_to_fp_1_idx", using: :btree

  create_table "futsal_places", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
    t.text     "deskripsi",       limit: 65535
    t.string   "alamat",          limit: 255
    t.string   "kecamatan",       limit: 100
    t.decimal  "latitude",                      precision: 9, scale: 6
    t.decimal  "longitude",                     precision: 9, scale: 6
    t.string   "phone",           limit: 45
    t.string   "email",           limit: 150
    t.integer  "user_id",         limit: 4
    t.string   "image",           limit: 255
    t.integer  "jumlah_lapangan", limit: 4
  end

  add_index "futsal_places", ["email"], name: "email_un", unique: true, using: :btree
  add_index "futsal_places", ["user_id"], name: "fk_futsal_places_1_idx", using: :btree

  create_table "galleries", force: :cascade do |t|
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "image",               limit: 255
    t.integer  "futsal_place_id",     limit: 4
    t.string   "gallery_description", limit: 150
  end

  add_index "galleries", ["futsal_place_id"], name: "fk_galleries_to_fp1_idx", using: :btree

  create_table "prices", force: :cascade do |t|
    t.decimal  "harga",                       precision: 10
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.time     "jam_mulai"
    t.time     "jam_akhir"
    t.string   "hari",            limit: 100
    t.integer  "futsal_place_id", limit: 4
    t.string   "array_hari",      limit: 50
  end

  add_index "prices", ["futsal_place_id"], name: "fk_prices_to_place1_idx", using: :btree

  create_table "reservations", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "testimonials", force: :cascade do |t|
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "name",            limit: 100
    t.string   "email",           limit: 150
    t.string   "isi",             limit: 255
    t.integer  "futsal_place_id", limit: 4
  end

  add_index "testimonials", ["futsal_place_id"], name: "fk_testimonials_to_fp1_idx", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "password_digest", limit: 255
    t.string   "email",           limit: 100
    t.string   "remember_digest", limit: 255
    t.string   "role",            limit: 45
    t.integer  "futsal_place_id", limit: 4
  end

  add_index "users", ["email"], name: "email_UNIQUE", unique: true, using: :btree

  add_foreign_key "bookings", "futsal_places", name: "fk_bookings_to_fp_1"
  add_foreign_key "futsal_places", "users", name: "fk_futsal_places_1"
  add_foreign_key "galleries", "futsal_places", name: "fk_galleries_to_fp1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "prices", "futsal_places", name: "fk_prices_to_place1"
  add_foreign_key "testimonials", "futsal_places", name: "fk_testimonials_to_fp1", on_update: :cascade, on_delete: :cascade
end
