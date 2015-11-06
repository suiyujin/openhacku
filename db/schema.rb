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

ActiveRecord::Schema.define(version: 20151106055042) do

  create_table "categories", force: :cascade do |t|
    t.string "name", limit: 255, null: false
  end

  add_index "categories", ["name"], name: "index_categories_on_name", unique: true, using: :btree

  create_table "keywords", force: :cascade do |t|
    t.string  "name",        limit: 255, null: false
    t.integer "category_id", limit: 4,   null: false
  end

  add_index "keywords", ["category_id"], name: "index_keywords_on_category_id", using: :btree
  add_index "keywords", ["name"], name: "index_keywords_on_name", using: :btree

  create_table "keywords_tickets", force: :cascade do |t|
    t.integer "keyword_id", limit: 4, null: false
    t.integer "ticket_id",  limit: 4, null: false
  end

  add_index "keywords_tickets", ["keyword_id", "ticket_id"], name: "index_keywords_tickets_on_keyword_id_and_ticket_id", unique: true, using: :btree
  add_index "keywords_tickets", ["keyword_id"], name: "index_keywords_tickets_on_keyword_id", using: :btree
  add_index "keywords_tickets", ["ticket_id"], name: "index_keywords_tickets_on_ticket_id", using: :btree

  create_table "keywords_users", force: :cascade do |t|
    t.integer "keyword_id", limit: 4, null: false
    t.integer "user_id",    limit: 4, null: false
  end

  add_index "keywords_users", ["keyword_id", "user_id"], name: "index_keywords_users_on_keyword_id_and_user_id", unique: true, using: :btree
  add_index "keywords_users", ["keyword_id"], name: "index_keywords_users_on_keyword_id", using: :btree
  add_index "keywords_users", ["user_id"], name: "index_keywords_users_on_user_id", using: :btree

  create_table "matching_tickets", force: :cascade do |t|
    t.boolean  "read_flag",            default: false, null: false
    t.integer  "ticket_id",  limit: 4,                 null: false
    t.integer  "user_id",    limit: 4,                 null: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_index "matching_tickets", ["ticket_id", "user_id"], name: "index_matching_tickets_on_ticket_id_and_user_id", unique: true, using: :btree
  add_index "matching_tickets", ["ticket_id"], name: "index_matching_tickets_on_ticket_id", using: :btree
  add_index "matching_tickets", ["user_id"], name: "index_matching_tickets_on_user_id", using: :btree

  create_table "reviews", force: :cascade do |t|
    t.integer  "score",        limit: 4,   null: false
    t.string   "comment",      limit: 255
    t.integer  "from_user_id", limit: 4,   null: false
    t.integer  "to_user_id",   limit: 4,   null: false
    t.integer  "ticket_id",    limit: 4,   null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "reviews", ["from_user_id"], name: "fk_rails_d4fa96a364", using: :btree
  add_index "reviews", ["ticket_id"], name: "index_reviews_on_ticket_id", using: :btree
  add_index "reviews", ["to_user_id"], name: "fk_rails_50805f2673", using: :btree

  create_table "stock_tickets", force: :cascade do |t|
    t.integer  "user_id",    limit: 4, null: false
    t.integer  "ticket_id",  limit: 4, null: false
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "stock_tickets", ["ticket_id"], name: "index_stock_tickets_on_ticket_id", using: :btree
  add_index "stock_tickets", ["user_id", "ticket_id"], name: "index_stock_tickets_on_user_id_and_ticket_id", unique: true, using: :btree
  add_index "stock_tickets", ["user_id"], name: "index_stock_tickets_on_user_id", using: :btree

  create_table "ticket_candidates", force: :cascade do |t|
    t.string   "comment",    limit: 255
    t.integer  "ticket_id",  limit: 4,   null: false
    t.integer  "user_id",    limit: 4,   null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "ticket_candidates", ["ticket_id", "user_id"], name: "index_ticket_candidates_on_ticket_id_and_user_id", unique: true, using: :btree
  add_index "ticket_candidates", ["ticket_id"], name: "index_ticket_candidates_on_ticket_id", using: :btree
  add_index "ticket_candidates", ["user_id"], name: "index_ticket_candidates_on_user_id", using: :btree

  create_table "tickets", force: :cascade do |t|
    t.string   "title",          limit: 255,                   null: false
    t.text     "body",           limit: 65535,                 null: false
    t.float    "time",           limit: 24,                    null: false
    t.integer  "price",          limit: 4,                     null: false
    t.string   "offline_place",  limit: 255
    t.boolean  "bought",                       default: false, null: false
    t.integer  "user_id",        limit: 4,                     null: false
    t.integer  "bought_user_id", limit: 4
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.boolean  "beginner",                     default: false, null: false
    t.boolean  "skype",                        default: false, null: false
    t.boolean  "hangouts",                     default: false, null: false
  end

  add_index "tickets", ["bought_user_id"], name: "index_tickets_on_bought_user_id", using: :btree
  add_index "tickets", ["user_id"], name: "index_tickets_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",                        null: false
    t.string   "encrypted_password",     limit: 255, default: "",                        null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,                         null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "authentication_token",   limit: 255
    t.datetime "created_at",                                                             null: false
    t.datetime "updated_at",                                                             null: false
    t.string   "username",               limit: 255
    t.string   "introduction",           limit: 255
    t.string   "profile_img_url",        limit: 255, default: "image/dummy_profile.jpg", null: false
    t.string   "header_img_url",         limit: 255, default: "image/dummy_header.jpg",  null: false
    t.string   "last_name",              limit: 255
    t.string   "first_name",             limit: 255
    t.integer  "sex",                    limit: 4
    t.float    "review_ave",             limit: 24
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "keywords", "categories"
  add_foreign_key "keywords_tickets", "keywords"
  add_foreign_key "keywords_tickets", "tickets"
  add_foreign_key "keywords_users", "keywords"
  add_foreign_key "keywords_users", "users"
  add_foreign_key "matching_tickets", "tickets"
  add_foreign_key "matching_tickets", "users"
  add_foreign_key "reviews", "tickets"
  add_foreign_key "reviews", "users", column: "from_user_id"
  add_foreign_key "reviews", "users", column: "to_user_id"
  add_foreign_key "stock_tickets", "tickets"
  add_foreign_key "stock_tickets", "users"
  add_foreign_key "ticket_candidates", "tickets"
  add_foreign_key "ticket_candidates", "users"
  add_foreign_key "tickets", "users"
end
