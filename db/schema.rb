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

ActiveRecord::Schema.define(version: 20140617044505) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
    t.integer  "service_modifier_1_id"
    t.integer  "service_modifier_2_id"
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
    t.text     "plan_name"
    t.text     "network_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "provider_charges", ["id"], name: "index_provider_charges_on_id", unique: true, using: :btree

  create_table "providers", force: true do |t|
    t.text     "npi"
    t.text     "npi_surrogate"
    t.text     "last_org_name"
    t.text     "first_name"
    t.string   "mi"
    t.string   "credentials"
    t.string   "gender",        limit: 1
    t.string   "entity_code"
    t.string   "street1"
    t.string   "street2"
    t.string   "city"
    t.string   "zip"
    t.string   "state"
    t.string   "country"
    t.string   "provider_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "providers", ["id"], name: "index_providers_on_id", unique: true, using: :btree

end
