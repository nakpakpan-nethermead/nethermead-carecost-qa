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

ActiveRecord::Schema.define(version: 20140621081356) do

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

  create_table "provider_charges", force: true do |t|
    t.string   "service_claim_number"
    t.string   "service_claim_type"
    t.string   "service_claim_line_number"
    t.integer  "provider_id"
    t.integer  "condition_procedure_id"
    t.integer  "condition_procedure_type_id"
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
    t.text     "service_quantity_units"
    t.text     "service_anesthesia_time"
    t.text     "service_modifier_1"
    t.text     "service_modifier_2"
    t.text     "service_state"
    t.text     "service_city"
    t.string   "service_zip_code"
    t.text     "service_specialty"
    t.text     "service_network_type"
    t.string   "service_year_from"
    t.string   "service_year_to"
    t.text     "service_place"
    t.text     "service_type"
    t.text     "service_plan_type"
    t.string   "patient_id"
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
  end

  add_index "providers", ["id"], name: "index_providers_on_id", unique: true, using: :btree

end
