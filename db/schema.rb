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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120419042233) do

  create_table "customers", :force => true do |t|
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "employees", :force => true do |t|
    t.integer  "role_id"
    t.integer  "merchant_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_manager"
  end

  create_table "keys", :force => true do |t|
    t.integer  "employee_id"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "code"
  end

  create_table "locations", :force => true do |t|
    t.integer  "merchant_id"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.float    "lat"
    t.float    "long"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "merchants", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "phone"
    t.string   "website"
  end

  create_table "offers", :force => true do |t|
    t.integer  "merchant_id"
    t.string   "type"
    t.string   "title"
    t.string   "byline"
    t.string   "category"
    t.string   "discount"
    t.string   "description"
    t.string   "terms"
    t.datetime "start"
    t.datetime "end"
    t.integer  "number_offered"
    t.boolean  "validation_required"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "requests", :force => true do |t|
    t.integer  "customer_id"
    t.integer  "offer_id"
    t.integer  "status_id"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "statuses", :force => true do |t|
    t.string   "type"
    t.string   "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.date     "birthday"
    t.string   "gender"
    t.boolean  "admin",           :default => false
  end

  create_table "validations", :force => true do |t|
    t.integer  "request_id"
    t.integer  "employee_id"
    t.integer  "status_id"
    t.string   "type"
    t.string   "criteria"
    t.string   "match"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
