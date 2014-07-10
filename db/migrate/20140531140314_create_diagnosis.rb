class CreateDiagnosis < ActiveRecord::Migration
  def change
    create_table :diagnosis do |t|
      t.integer :condition_id
      t.text :short_name
      t.text :full_name
      t.string :codeset,  :limit => 50
      t.string :code,  :limit => 50
      t.timestamps
    end
    add_index :diagnosis, :id, unique: true
  end
end
