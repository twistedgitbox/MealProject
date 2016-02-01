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

ActiveRecord::Schema.define(version: 20160201002531) do

  create_table "org_companies", force: :cascade do |t|
    t.string   "name",             limit: 255,   null: false
    t.string   "avatar",           limit: 255
    t.text     "description",      limit: 65535
    t.string   "verification_doc", limit: 255
    t.boolean  "verified"
    t.integer  "type_fee_id",      limit: 4
    t.integer  "type_company_id",  limit: 4
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "org_companies_contacts", force: :cascade do |t|
    t.integer "org_company_id", limit: 4, null: false
    t.integer "org_contact_id", limit: 4, null: false
  end

  create_table "org_contacts", force: :cascade do |t|
    t.string   "address1",        limit: 255, null: false
    t.string   "address2",        limit: 255
    t.string   "city",            limit: 255, null: false
    t.string   "postal_code",     limit: 255, null: false
    t.string   "email",           limit: 255, null: false
    t.string   "business_number", limit: 255, null: false
    t.string   "cell_number",     limit: 255
    t.float    "latitude",        limit: 24,  null: false
    t.float    "longitude",       limit: 24,  null: false
    t.string   "avatar",          limit: 255
    t.integer  "typ_contact_id",  limit: 4
    t.integer  "typ_country_id",  limit: 4
    t.integer  "typ_region_id",   limit: 4
    t.integer  "org_company_id",  limit: 4
    t.integer  "org_person_id",   limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "org_contacts_people", force: :cascade do |t|
    t.integer  "org_person_id",  limit: 4, null: false
    t.integer  "org_contact_id", limit: 4, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "org_people", force: :cascade do |t|
    t.integer  "typ_position_id",        limit: 4
    t.integer  "org_company_id",         limit: 4
    t.string   "first_name",             limit: 255,   null: false
    t.string   "last_name",              limit: 255,   null: false
    t.string   "stripe_publishable_key", limit: 255
    t.string   "stripe_secret_key",      limit: 255
    t.string   "stripe_user_id",         limit: 255
    t.string   "stripe_currency",        limit: 255
    t.string   "stripe_account_type",    limit: 255
    t.text     "stripe_account_status",  limit: 65535
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  create_table "org_products", force: :cascade do |t|
    t.integer  "org_company_id",         limit: 4
    t.integer  "typ_category_id",        limit: 4
    t.integer  "typ_subcategory_id",     limit: 4
    t.string   "name",                   limit: 255,                                          null: false
    t.text     "description",            limit: 65535,                                        null: false
    t.decimal  "weight_in_grams",                      precision: 10,           default: 0,   null: false
    t.decimal  "price",                                precision: 5,  scale: 2,               null: false
    t.integer  "available_quantity",     limit: 4,                                            null: false
    t.datetime "expiry_date",                                                                 null: false
    t.float    "latitude",               limit: 24,                                           null: false
    t.float    "longitude",              limit: 24,                                           null: false
    t.boolean  "online_order_available",                                                      null: false
    t.float    "tax_amount",             limit: 24,                             default: 0.0
    t.string   "image",                  limit: 255
    t.datetime "created_at",                                                                  null: false
    t.datetime "updated_at",                                                                  null: false
  end

  create_table "trx_order_fees", force: :cascade do |t|
    t.float    "fee_amount",   limit: 24, null: false
    t.integer  "trx_order_id", limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "trx_order_items", force: :cascade do |t|
    t.string   "name",                limit: 255,                          null: false
    t.string   "description",         limit: 255
    t.decimal  "weight_in_grams",                 precision: 10,           null: false
    t.decimal  "price",                           precision: 20, scale: 4, null: false
    t.decimal  "available_quantity",              precision: 10,           null: false
    t.integer  "quantity",            limit: 4,                            null: false
    t.datetime "expiry_date",                                              null: false
    t.string   "image",               limit: 255,                          null: false
    t.integer  "org_company_id",      limit: 4
    t.integer  "typ_category_id",     limit: 4
    t.integer  "typ_subcategory_id",  limit: 4
    t.integer  "trx_order_id",        limit: 4
    t.integer  "shipping_address_id", limit: 4
    t.decimal  "net_amount",                      precision: 20, scale: 4
    t.decimal  "tax_amount",                      precision: 20, scale: 4
    t.boolean  "delivery_status"
    t.datetime "created_at",                                               null: false
    t.datetime "updated_at",                                               null: false
  end

  create_table "trx_orders", force: :cascade do |t|
    t.integer  "org_company_id",     limit: 4
    t.integer  "bill_to_contact_id", limit: 4
    t.integer  "ship_to_order_id",   limit: 4
    t.integer  "trx_order_fee_id",   limit: 4
    t.decimal  "total_amount",                   precision: 20, scale: 4
    t.datetime "purchased_at"
    t.string   "transport_method",   limit: 255
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
  end

  create_table "typ_categories", force: :cascade do |t|
    t.string   "name",       limit: 255, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "typ_companies", force: :cascade do |t|
    t.string   "name",       limit: 255, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "typ_contacts", force: :cascade do |t|
    t.string   "name",       limit: 255, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "typ_countries", force: :cascade do |t|
    t.string   "iso",           limit: 255
    t.string   "iso3",          limit: 255
    t.string   "fips",          limit: 255
    t.string   "country",       limit: 255
    t.string   "continent",     limit: 255
    t.string   "currency_code", limit: 255
    t.string   "currency_name", limit: 255
    t.string   "phone_prefix",  limit: 255
    t.string   "postal_code",   limit: 255
    t.string   "languages",     limit: 255
    t.string   "geonameid",     limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "typ_fees", force: :cascade do |t|
    t.string   "name",           limit: 255, null: false
    t.float    "fee_percentage", limit: 24,  null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "typ_positions", force: :cascade do |t|
    t.string   "name",       limit: 255, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "typ_regions", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.string   "timezone",       limit: 255
    t.integer  "typ_country_id", limit: 4
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "typ_sales_taxes", force: :cascade do |t|
    t.float    "tax_rate",      limit: 24, null: false
    t.integer  "typ_region_id", limit: 4
    t.integer  "typ_tax_id",    limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "typ_subcategories", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.integer  "typ_category_id", limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "typ_taxes", force: :cascade do |t|
    t.string   "name",       limit: 255, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

end
