class CreateConditions < ActiveRecord::Migration
  def change
    drop_table :conditions
    create_table :conditions do |t|
      t.text :consumer_name
      t.text :clinical_name
      t.string :condition_type,  :limit => 50
      t.string :codeset,  :limit => 50
      t.string :code,  :limit => 50
      t.timestamps
    end
    add_index :conditions, :id, unique: true
  end
end
