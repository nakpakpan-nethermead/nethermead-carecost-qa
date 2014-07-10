class CreateProviderAttributes < ActiveRecord::Migration
  def change
    create_table :provider_attributes do |t|
      t.string :name
      t.string :value
      t.string :img
      t.string :data_type
      t.timestamps
    end
  end
end
