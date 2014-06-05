class CreateNetworkProviders < ActiveRecord::Migration
  def change
    create_table :network_providers do |t|
      t.integer :network_id
      t.integer :provider_id
      t.timestamp :network_since

      t.timestamps
    end
    add_index :network_providers, :id,                unique: true
  end
end
