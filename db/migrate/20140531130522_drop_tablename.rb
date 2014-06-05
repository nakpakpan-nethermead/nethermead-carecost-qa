class DropTablename < ActiveRecord::Migration
  def up
  	# drop_table :conditions
  	drop_table :diagnoses
  	drop_table :providers
  	drop_table :provider_practices
  	drop_table :network_providers
  	drop_table :cities
  	drop_table :counties
  	drop_table :provider_additional_attributes
  	drop_table :provider_charges
  	drop_table :practice_organizations
  	drop_table :userlogins
  	drop_table :zips
  	drop_table :provider_networks
  	drop_table :categories
  	drop_table :welcomes

  	create_table :conditions do |t|
      t.string :consumer_name
      t.string :clinical_name
      t.string :type,  :limit => 50
      t.string :codeset,  :limit => 50
      t.string :code,  :limit => 50
      t.timestamps
    end

    create_table :diagnosis do |t|
      t.string :short_name
      t.string :full_name
      t.string :codeset,  :limit => 50
      t.string :code,  :limit => 50
      t.timestamps
    end
    
    create_table :providers do |t|
      t.string :first_name
      t.string :last_name
      t.string :designations,  :limit => 50
      t.string :img_url,  :limit => 50
      t.timestamp :physian_since
      t.string :type,  :limit => 50
      t.timestamps
    end

    create_table :provider_practices do |t|
      t.integer :practice_id
      t.integer :provider_id
      t.timestamp :affiliation_since
      t.string :practice_scope,  :limit => 50
      t.timestamps
    end

    create_table :network_providers do |t|
      t.integer :network_id
      t.integer :provider_id
      t.timestamp :network_since
      t.timestamps
    end

    create_table :cities do |t|
      t.string :name
      t.string :county,  :limit => 50
      t.string :state_code,  :limit => 50
      t.string :zip_code,  :limit => 50
      t.timestamps
    end

    create_table :counties do |t|
      t.string :name
      t.string :state_code,  :limit => 50
      t.timestamps
    end

    create_table :provider_additional_attributes do |t|
      t.string :attribute_name
      t.string :attribute_value,  :limit => 50
      t.string :attribute_value_img,  :limit => 50
      t.string :attribute_data_type,  :limit => 50
      t.timestamps
    end

    create_table :provider_charges do |t|
      t.integer :provider_id
      t.integer :condition_procedure_id
      t.integer :condition_diagnosis_id
      t.string :service_charge,  :limit => 50
      t.string :service_quantity,  :limit => 50
      t.timestamps
    end

    create_table :practice_organizations do |t|
      t.string :name
      t.string :place_of_service_type,  :limit => 50
      t.string :location_address,  :limit => 50
      t.string :location_city,  :limit => 50
      t.string :location_zip,  :limit => 50
      t.string :location_county,  :limit => 50
      t.string :location_state,  :limit => 50
      t.string :type,  :limit => 50
      t.string :company_number,  :limit => 50
      t.string :company_number_type,  :limit => 50
      t.timestamps
    end

    create_table :userlogins do |t|
      t.integer :user_id
      t.string :password,  :limit => 50
      t.string :status,  :limit => 50
      t.timestamps
    end

    create_table :zips do |t|
      t.string :zip_code,  :limit => 50
      t.string :city_name
      t.string :county_name
      t.string :state_code,  :limit => 50
      t.timestamps
    end

    create_table :provider_networks do |t|
      t.string :name
      t.timestamps
    end
  end
end
