class CreateProviderAdditionalAttributes < ActiveRecord::Migration
  def change
    create_table :provider_additional_attributes do |t|
      t.string :attribute_name
      t.string :attribute_value,  :limit => 50
      t.string :attribute_value_img,  :limit => 50
      t.string :attribute_data_type,  :limit => 50

      t.timestamps
    end
    add_index :provider_additional_attributes, :Id,                unique: true
  end
end
