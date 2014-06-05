class CreatePracticeOrganizations < ActiveRecord::Migration
  def change
    create_table :practice_organizations do |t|
      t.string :name
      t.string :place_of_service_type,  :limit => 50
      t.string :location_address,  :limit => 50
      t.string :location_city,  :limit => 50
      t.string :location_zip,  :limit => 50
      t.string :location_county,  :limit => 50
      t.string :location_state,  :limit => 50
      t.string :practice_type,  :limit => 50
      t.string :company_number,  :limit => 50
      t.string :company_number_type,  :limit => 50

      t.timestamps
    end
    add_index :practice_organizations, :id,                unique: true
  end
end
