class CreateDiagnoses < ActiveRecord::Migration
  def change
    create_table :diagnoses do |t|
      t.string :short_name
      t.string :full_name
      t.string :codeset,  :limit => 50
      t.string :code,  :limit => 50

      t.timestamps
    end
    add_index :diagnoses, :id,                unique: true
  end
end
