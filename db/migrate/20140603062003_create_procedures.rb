class CreateProcedures < ActiveRecord::Migration
  def up
    drop_table :procedures
  	create_table :procedures do |t|
  	  t.integer :condition_id, :limit =>8
      t.text :short_name
      t.text :full_name
      t.string :codeset,  :limit => 50
      t.string :code,  :limit => 50
      t.timestamps
    end
    add_index :procedures, :id, unique: true
  end
end
