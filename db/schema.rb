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

ActiveRecord::Schema.define(version: 20150924080211) do

  create_table "additionals", force: :cascade do |t|
    t.string   "additional_sources", limit: 255, null: false
    t.integer  "order_id",           limit: 4
    t.integer  "user_id",            limit: 4
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "additionals", ["order_id"], name: "index_additionals_on_order_id", using: :btree
  add_index "additionals", ["user_id"], name: "index_additionals_on_user_id", using: :btree

  create_table "answers", force: :cascade do |t|
    t.integer  "order_id",            limit: 4
    t.string   "attachment",          limit: 255,   null: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.text     "notification_params", limit: 65535
    t.string   "status",              limit: 255
    t.string   "transaction_id",      limit: 255
    t.datetime "purchased_at"
  end

  add_index "answers", ["order_id"], name: "index_answers_on_order_id", using: :btree

  create_table "extras", force: :cascade do |t|
    t.string   "material",   limit: 255, null: false
    t.integer  "order_id",   limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "extras", ["order_id"], name: "index_extras_on_order_id", using: :btree

  create_table "materials", force: :cascade do |t|
    t.string   "additional_materials", limit: 255
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "paper_id",             limit: 4
  end

  add_index "materials", ["paper_id"], name: "index_materials_on_paper_id", using: :btree

  create_table "messages", force: :cascade do |t|
    t.integer  "order_id",   limit: 4
    t.integer  "user_id",    limit: 4
    t.text     "content",    limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id",             limit: 4
    t.string   "type_of_paper",       limit: 255
    t.string   "topic",               limit: 255
    t.integer  "pages",               limit: 4
    t.datetime "deadline"
    t.string   "discipline",          limit: 255
    t.string   "type_of_service",     limit: 255
    t.string   "format",              limit: 255
    t.text     "paper_instructions",  limit: 65535
    t.datetime "created_at",                                                       null: false
    t.datetime "updated_at",                                                       null: false
    t.decimal  "half_price",                        precision: 10
    t.decimal  "price",                             precision: 10
    t.text     "notification_params", limit: 65535
    t.string   "status",              limit: 255
    t.string   "transaction_id",      limit: 255
    t.datetime "purchased_at"
    t.boolean  "answered",            limit: 1,                    default: false
    t.boolean  "fully_paid",          limit: 1,                    default: false
  end

  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "papers", force: :cascade do |t|
    t.string   "type_of_paper",      limit: 255
    t.string   "topic",              limit: 255
    t.integer  "pages",              limit: 4
    t.string   "discipline",         limit: 255
    t.boolean  "free",               limit: 1,                    default: false
    t.string   "format",             limit: 255
    t.text     "paper_instructions", limit: 65535
    t.datetime "created_at",                                                      null: false
    t.datetime "updated_at",                                                      null: false
    t.string   "document",           limit: 255
    t.string   "sample_document",    limit: 255
    t.decimal  "price",                            precision: 10
  end

  create_table "purchases", force: :cascade do |t|
    t.integer  "user_id",             limit: 4
    t.integer  "paper_id",            limit: 4
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.text     "notification_params", limit: 65535
    t.string   "status",              limit: 255
    t.string   "transaction_id",      limit: 255
    t.datetime "purchased_at"
  end

  add_index "purchases", ["paper_id"], name: "index_purchases_on_paper_id", using: :btree
  add_index "purchases", ["user_id"], name: "index_purchases_on_user_id", using: :btree

  create_table "usermaterials", force: :cascade do |t|
    t.string   "additional_sources", limit: 255, null: false
    t.integer  "order_id",           limit: 4
    t.integer  "user_id",            limit: 4
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "usermaterials", ["order_id"], name: "index_usermaterials_on_order_id", using: :btree
  add_index "usermaterials", ["user_id"], name: "index_usermaterials_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",           limit: 255
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.string   "password_digest", limit: 255
    t.string   "remember_digest", limit: 255
    t.string   "photo",           limit: 255
    t.boolean  "admin",           limit: 1,   default: false
    t.string   "reset_digest",    limit: 255
    t.datetime "reset_sent_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  add_foreign_key "additionals", "orders"
  add_foreign_key "additionals", "users"
  add_foreign_key "answers", "orders"
  add_foreign_key "extras", "orders"
  add_foreign_key "materials", "papers"
  add_foreign_key "orders", "users"
  add_foreign_key "purchases", "papers"
  add_foreign_key "purchases", "users"
  add_foreign_key "usermaterials", "orders"
  add_foreign_key "usermaterials", "users"
end
