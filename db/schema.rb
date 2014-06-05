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

ActiveRecord::Schema.define(version: 20140604114343) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cities", force: true do |t|
    t.string   "name"
    t.string   "county",     limit: 50
    t.string   "state_code", limit: 50
    t.string   "zip_code",   limit: 50
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cities", ["id"], name: "index_cities_on_id", unique: true, using: :btree

  create_table "clients", force: true do |t|
    t.string   "name"
    t.string   "logo_url",   limit: 50
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "clients", ["id"], name: "index_clients_on_id", unique: true, using: :btree

  create_table "conditions", force: true do |t|
    t.string   "consumer_name"
    t.string   "clinical_name"
    t.string   "condition_type", limit: 50
    t.string   "codeset",        limit: 50
    t.string   "code",           limit: 50
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "conditions", ["id"], name: "index_conditions_on_id", unique: true, using: :btree

  create_table "counties", force: true do |t|
    t.string   "name"
    t.string   "state_code", limit: 50
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "counties", ["id"], name: "index_counties_on_id", unique: true, using: :btree

  create_table "diagnosis", force: true do |t|
    t.string   "short_name"
    t.string   "full_name"
    t.string   "codeset",      limit: 50
    t.string   "code",         limit: 50
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "condition_id", limit: 8
  end

  add_index "diagnosis", ["id"], name: "index_diagnosis_on_id", unique: true, using: :btree

  create_table "network_providers", force: true do |t|
    t.integer  "network_id"
    t.integer  "provider_id"
    t.datetime "network_since"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "network_providers", ["id"], name: "index_network_providers_on_id", unique: true, using: :btree

  create_table "people", force: true do |t|
    t.string   "name"
    t.string   "condition"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "practice_organizations", force: true do |t|
    t.string   "name"
    t.string   "place_of_service_type", limit: 50
    t.string   "location_address",      limit: 50
    t.string   "location_city",         limit: 50
    t.string   "location_zip",          limit: 50
    t.string   "location_county",       limit: 50
    t.string   "location_state",        limit: 50
    t.string   "type",                  limit: 50
    t.string   "company_number",        limit: 50
    t.string   "company_number_type",   limit: 50
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "practice_organizations", ["id"], name: "index_practice_organizations_on_id", unique: true, using: :btree

  create_table "procedures", force: true do |t|
    t.integer  "condition_id", limit: 8
    t.string   "short_name"
    t.string   "full_name"
    t.string   "codeset",      limit: 50
    t.string   "code",         limit: 50
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "procedures", ["id"], name: "index_procedures_on_id", unique: true, using: :btree

  create_table "products", force: true do |t|
    t.string   "name"
    t.integer  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "provider_additional_attributes", force: true do |t|
    t.string   "attribute_name"
    t.string   "attribute_value",     limit: 50
    t.string   "attribute_value_img", limit: 50
    t.string   "attribute_data_type", limit: 50
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "provider_additional_attributes", ["id"], name: "index_provider_additional_attributes_on_id", unique: true, using: :btree

  create_table "provider_charges", force: true do |t|
    t.integer  "provider_id"
    t.integer  "condition_procedure_id"
    t.integer  "condition_diagnosis_id"
    t.string   "service_charge",         limit: 50
    t.string   "service_quantity",       limit: 50
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "provider_charges", ["id"], name: "index_provider_charges_on_id", unique: true, using: :btree

  create_table "provider_networks", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "provider_networks", ["id"], name: "index_provider_networks_on_id", unique: true, using: :btree

  create_table "provider_practices", force: true do |t|
    t.integer  "practice_id"
    t.integer  "provider_id"
    t.datetime "affiliation_since"
    t.string   "practice_scope",    limit: 50
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "provider_practices", ["id"], name: "index_provider_practices_on_id", unique: true, using: :btree

  create_table "providers", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "designations",  limit: 50
    t.string   "img_url",       limit: 50
    t.datetime "physian_since"
    t.string   "type",          limit: 50
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "providers", ["id"], name: "index_providers_on_id", unique: true, using: :btree

  create_table "userlogins", force: true do |t|
    t.integer  "user_id"
    t.string   "password",   limit: 50
    t.string   "status",     limit: 50
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "userlogins", ["id"], name: "index_userlogins_on_id", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "zips", force: true do |t|
    t.string   "zip_code",    limit: 50
    t.string   "city_name"
    t.string   "county_name"
    t.string   "state_code",  limit: 50
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "zips", ["id"], name: "index_zips_on_id", unique: true, using: :btree

end
