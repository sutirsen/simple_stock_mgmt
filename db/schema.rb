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

ActiveRecord::Schema.define(version: 20200105094246) do

  create_table "collections", force: :cascade do |t|
    t.integer "third_party_id"
    t.date "collection_date"
    t.text "details"
    t.string "bill_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["third_party_id"], name: "index_collections_on_third_party_id"
  end

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

  create_table "coupons", force: :cascade do |t|
    t.string "name"
    t.string "type_of_discount"
    t.decimal "amount"
    t.datetime "valid_from"
    t.datetime "valid_till"
    t.boolean "is_active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "employee_leaves", force: :cascade do |t|
    t.integer "employee_id"
    t.integer "leave_amount"
    t.string "type_of_leave"
    t.integer "financial_year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_employee_leaves_on_employee_id"
  end

  create_table "employees", force: :cascade do |t|
    t.string "name"
    t.integer "company_id"
    t.text "address"
    t.string "voter_card_no"
    t.string "aadhar_card_no"
    t.string "pan_no"
    t.date "date_of_joining"
    t.string "designation"
    t.string "type_of_work"
    t.text "job_desc"
    t.text "terms"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "salary"
    t.string "bank_name"
    t.string "bank_acc_no"
    t.string "ifsc_code"
    t.string "phone_no"
    t.string "email"
    t.index ["company_id"], name: "index_employees_on_company_id"
  end

  create_table "financial_transactions", force: :cascade do |t|
    t.string "monitory_type"
    t.integer "monitory_id"
    t.decimal "amount"
    t.integer "type_of_transaction"
    t.integer "payment_method"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["monitory_type", "monitory_id"], name: "index_financial_transactions_on_monitory_type_and_monitory_id"
  end

  create_table "leave_transactions", force: :cascade do |t|
    t.integer "employee_id"
    t.integer "employee_leave_id"
    t.date "start_date"
    t.date "end_date"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_leave_transactions_on_employee_id"
    t.index ["employee_leave_id"], name: "index_leave_transactions_on_employee_leave_id"
  end

  create_table "operational_expenses", force: :cascade do |t|
    t.string "name"
    t.text "details"
    t.date "paid_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_items", force: :cascade do |t|
    t.integer "order_id"
    t.integer "product_id"
    t.decimal "qty"
    t.decimal "selling_price"
    t.decimal "total_item_cost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_items_on_order_id"
    t.index ["product_id"], name: "index_order_items_on_product_id"
  end

  create_table "order_taxes", force: :cascade do |t|
    t.integer "tax_id"
    t.decimal "tax_val"
    t.integer "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_taxes_on_order_id"
    t.index ["tax_id"], name: "index_order_taxes_on_tax_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "third_party_id"
    t.decimal "total_cost"
    t.decimal "total_tax"
    t.decimal "discounted_amount"
    t.decimal "total_payable"
    t.integer "coupon_id"
    t.string "bill_no"
    t.string "tr_no"
    t.boolean "with_tax"
    t.text "remarks"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "frieght_less"
    t.decimal "freight_less"
    t.date "bill_date"
    t.string "place_of_delivery", default: ""
    t.index ["coupon_id"], name: "index_orders_on_coupon_id"
    t.index ["third_party_id"], name: "index_orders_on_third_party_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "product_type"
    t.string "packing"
    t.string "unit"
    t.decimal "trading_price"
    t.decimal "mrp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "hsn"
    t.string "batch"
    t.string "mfg_date"
    t.string "use_within"
    t.decimal "available_units"
    t.string "manufactured_by"
  end

  create_table "purchases", force: :cascade do |t|
    t.integer "raw_material_id"
    t.integer "third_party_id"
    t.decimal "rate_of_unit"
    t.decimal "qty"
    t.string "batch_no"
    t.date "expiry_date"
    t.text "remarks"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "amount"
    t.index ["raw_material_id"], name: "index_purchases_on_raw_material_id"
    t.index ["third_party_id"], name: "index_purchases_on_third_party_id"
  end

  create_table "raw_materials", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.decimal "qty"
    t.string "unit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "hsn"
    t.string "gst_rate"
    t.decimal "net_price"
    t.date "purchased_on"
    t.string "vendor_name"
    t.decimal "total_price"
  end

  create_table "taxes", force: :cascade do |t|
    t.string "name"
    t.decimal "perc"
    t.boolean "is_active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "third_parties", force: :cascade do |t|
    t.string "name"
    t.text "address"
    t.string "phn_number"
    t.string "gst_number"
    t.decimal "due"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "type_of_party"
    t.string "pan"
  end

  create_table "transports", force: :cascade do |t|
    t.integer "order_id"
    t.string "name"
    t.string "documents_through"
    t.string "no_of_cases"
    t.string "contact_no"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_transports_on_order_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
