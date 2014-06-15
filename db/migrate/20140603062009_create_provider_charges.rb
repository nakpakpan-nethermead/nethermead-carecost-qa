class CreateProviderCharges < ActiveRecord::Migration
  def up
  	create_table :provider_charges do |t|
      
      t.string :service_claim_number
      t.string :service_claim_type
      t.string :service_claim_line_number
      t.integer :provider_id
      t.integer :condition_procedure_id
      t.string :condition_procedure_type_id
      t.integer :condition_icd_diagnosis_1_id
      t.integer :condition_icd_diagnosis_2_id
      t.integer :condition_icd_diagnosis_3_id
      t.integer :condition_icd_diagnosis_4_id
      t.integer :condition_icd_diagnosis_5_id
      t.integer :condition_icd_diagnosis_6_id
      t.integer :condition_icd_procedure_1_id
      t.integer :condition_icd_procedure_2_id
      t.integer :condition_icd_procedure_3_id
      t.integer :condition_icd_procedure_4_id
      t.integer :condition_icd_procedure_5_id
      t.integer :condition_icd_procedure_6_id
      t.integer :service_charge
      t.integer :service_quantity
      t.string :service_quantity_units
      t.string :service_anesthesia_time
      t.integer :service_modifier_1_id
      t.integer :service_modifier_2_id
      t.string :service_state
      t.string :service_city
      t.string :service_zip_code
      t.text :service_specialty
      t.text :service_network_type
      t.integer :service_year_from
      t.integer :service_year_to
      t.string :service_place
      t.string :service_type
      t.string :service_plan_type
      t.integer :patient_id
      t.string :patient_year_of_birth
      t.string :patient_gender
      t.text :plan_name
      t.text :network_name
      t.timestamps
    end
    add_index :provider_charges, :id, unique: true
  end
end