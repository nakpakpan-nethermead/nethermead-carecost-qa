class CreateProcedures < ActiveRecord::Migration
  def up
  	create_table :procedures do |t|
  	  t.integer :condition_id, :limit =>8
      t.string :short_name
      t.string :full_name
      t.string :codeset,  :limit => 50
      t.string :code,  :limit => 50
      t.timestamps
    end
    add_index :procedures, :id, unique: true
    change_column :procedures, :id, :integer, :null => false, :auto_increment => true
  end
end
