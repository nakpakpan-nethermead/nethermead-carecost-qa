class CreateProviders < ActiveRecord::Migration
  def up
    create_table :providers do |t|
	
	t.text :npi
	t.text :npi_surrogate
	t.text :first_name
	t.text :org_last_name
	t.text :designations, :limit => 50
	t.string :img_url, :limit => 50
	t.timestamps :physician_since
	t.string :provider_type, :limit => 50
	t.string :gender, :limit => 1
	t.string :provider_address, :limit => 50
	t.string :provider_suite_number, :limit => 50
	t.string :provider_city
	t.string :provider_zip
	t.string :provider_county
	t.string :provider_state
	t.string :provider_country
	t.string :provider_entity_type

	t.timestamps
    end
    add_index :providers, :id, unique: true
  end
end
