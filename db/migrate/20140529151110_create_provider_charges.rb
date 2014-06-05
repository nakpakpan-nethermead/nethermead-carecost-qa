class CreateProviderCharges < ActiveRecord::Migration
  def change
    create_table :provider_charges do |t|
      t.integer :provider_id
      t.integer :dondition_Procedure_id
      t.integer :condition_diagnosis_id
      t.string :service_charge,  :limit => 50
      t.string :service_quantity,  :limit => 50

      t.timestamps
    end
    add_index :provider_charges, :id,                unique: true
  end
end
