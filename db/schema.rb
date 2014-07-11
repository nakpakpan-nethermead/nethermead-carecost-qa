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

ActiveRecord::Schema.define(version: 20140711101714) do

  create_table "conditions", force: true do |t|
    t.text     "consumer_name"
    t.text     "clinical_name"
    t.string   "condition_type", limit: 50
    t.string   "codeset",        limit: 50
    t.string   "code",           limit: 50
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "conditions", ["id"], name: "index_conditions_on_id", unique: true, using: :btree

  create_table "diagnosis", force: true do |t|
    t.integer  "condition_id"
    t.text     "short_name"
    t.text     "full_name"
    t.string   "codeset",      limit: 50
    t.string   "code",         limit: 50
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "diagnosis", ["id"], name: "index_diagnosis_on_id", unique: true, using: :btree

  create_table "procedures", force: true do |t|
    t.integer  "condition_id", limit: 8
    t.text     "short_name"
    t.text     "full_name"
    t.string   "codeset",      limit: 50
    t.string   "code",         limit: 50
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "procedures", ["id"], name: "index_procedures_on_id", unique: true, using: :btree

  create_table "provider_attributes", force: true do |t|
    t.string   "attribute_name"
    t.string   "attribute_value",   limit: 50
    t.string   "value_img"
    t.string   "data_type",         limit: 50
    t.string   "provider_id",       limit: 50
    t.string   "context",           limit: 50
    t.string   "display_type",      limit: 50
    t.string   "display_format",    limit: 50
    t.string   "series_point_type", limit: 50
    t.string   "series_value",      limit: 50
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "provider_attributes", ["id"], name: "index_provider_attributes_on_id", unique: true, using: :btree

  create_table "provider_charges", force: true do |t|
    t.string   "service_claim_number"
    t.string   "service_claim_type"
    t.string   "service_claim_line_number"
    t.integer  "provider_id"
    t.integer  "condition_procedure_id"
    t.string   "condition_procedure_type_id"
    t.integer  "condition_icd_diagnosis_1_id"
    t.integer  "condition_icd_diagnosis_2_id"
    t.integer  "condition_icd_diagnosis_3_id"
    t.integer  "condition_icd_diagnosis_4_id"
    t.integer  "condition_icd_diagnosis_5_id"
    t.integer  "condition_icd_diagnosis_6_id"
    t.integer  "condition_icd_procedure_1_id"
    t.integer  "condition_icd_procedure_2_id"
    t.integer  "condition_icd_procedure_3_id"
    t.integer  "condition_icd_procedure_4_id"
    t.integer  "condition_icd_procedure_5_id"
    t.integer  "condition_icd_procedure_6_id"
    t.integer  "service_charge"
    t.integer  "service_quantity"
    t.string   "service_quantity_units"
    t.string   "service_anesthesia_time"
    t.integer  "service_modifier_1"
    t.integer  "service_modifier_2"
    t.string   "service_state"
    t.string   "service_city"
    t.string   "service_zip_code"
    t.text     "service_specialty"
    t.text     "service_network_type"
    t.integer  "service_year_from"
    t.integer  "service_year_to"
    t.string   "service_place"
    t.string   "service_type"
    t.string   "service_plan_type"
    t.integer  "patient_id"
    t.string   "patient_year_of_birth"
    t.string   "patient_gender"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "provider_charges", ["id"], name: "index_provider_charges_on_id", unique: true, using: :btree

  create_table "providers", force: true do |t|
    t.text     "npi"
    t.text     "npi_surrogate"
    t.text     "first_name"
    t.text     "org_last_name"
    t.text     "designations",          limit: 255
    t.string   "img_url",               limit: 50
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider_type",         limit: 50
    t.string   "gender",                limit: 1
    t.string   "provider_address",      limit: 50
    t.string   "provider_suite_number", limit: 50
    t.string   "provider_city"
    t.string   "provider_zip"
    t.string   "provider_county"
    t.string   "provider_state"
    t.string   "provider_country"
    t.string   "provider_entity_type"
    t.string   "physician_since"
  end

  add_index "providers", ["id"], name: "index_providers_on_id", unique: true, using: :btree

  create_table "summary_emails", force: true do |t|
    t.string   "email"
    t.text     "message"
    t.integer  "is_email",   default: 0
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_favorites", force: true do |t|
    t.integer  "user_id"
    t.integer  "procedure_id"
    t.integer  "provider_id"
    t.date     "date_added"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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

end
