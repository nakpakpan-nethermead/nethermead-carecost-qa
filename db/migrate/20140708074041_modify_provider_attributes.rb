class ModifyProviderAttributes < ActiveRecord::Migration
  def change
    rename_column :provider_attributes, :name, :attribute_name
    rename_column :provider_attributes, :value, :attribute_value
    rename_column :provider_attributes, :img, :value_img
    add_column :provider_attributes, :provider_id, :string
    add_column :provider_attributes, :context, :string
    add_column :provider_attributes, :display_type, :string
    add_column :provider_attributes, :display_format, :string
    add_column :provider_attributes, :series_point_type, :string
    add_column :provider_attributes, :series_value, :string
  end
	add_index :provider_attributes, :id, unique: true
end

