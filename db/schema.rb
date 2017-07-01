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

ActiveRecord::Schema.define(version: 20170701143342) do

  create_table "companies", force: :cascade do |t|
    t.string "company_name"
    t.string "branch_name"
    t.decimal "ph_number"
    t.string "email"
    t.string "web_site"
    t.string "vat_number"
    t.string "cst_number"
    t.string "trade_license_number"
    t.string "drug_license_number"
    t.string "registration_number"
    t.string "authorized_sign_img"
    t.string "company_logo_img"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
