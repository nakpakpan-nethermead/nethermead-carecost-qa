class ModifyProviderAttributes < ActiveRecord::Migration
  def up
    drop_table :provider_attributes if table_exists? :provider_attributes
	create_table :provider_attributes do |t|
	 t.string :attribute_name
	 t.string :attribute_value, :limit => 50 
	 t.string :value_img
	 t.string :data_type, :limit => 50
	 t.string :provider_id, :limit => 50
	 t.string :context, :limit => 50
	 t.string :display_type, :limit => 50
	 t.string :display_format, :limit => 50
	 t.string :series_point_type, :limit => 50
	 t.string :series_value, :limit => 50

	 t.timestamps
  end
  	 add_index :provider_attributes, :id, unique: true
 end
end
