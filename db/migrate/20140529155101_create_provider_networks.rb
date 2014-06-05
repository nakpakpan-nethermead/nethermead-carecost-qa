class CreateProviderNetworks < ActiveRecord::Migration
  def change
    create_table :provider_networks do |t|
      t.string :name

      t.timestamps
    end
    add_index :provider_networks, :id,                unique: true
  end
end
