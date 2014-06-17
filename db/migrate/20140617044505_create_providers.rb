class CreateProviders < ActiveRecord::Migration
  def up
    create_table :providers do |t|
	
	t.text :npi
	t.text :npi_surrogate
	t.text :last_org_name
	t.text :first_name
	t.string :mi
	t.string :credentials
	t.string :gender, :limit => 1
	t.string :entity_code
	t.string :street1
	t.string :street2
	t.string :city
	t.string :zip
	t.string :state
	t.string :country
	t.string :provider_type
	
	t.timestamps
    end
    add_index :providers, :id, unique: true
  end
end
