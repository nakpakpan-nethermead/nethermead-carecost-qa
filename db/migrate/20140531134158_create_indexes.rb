class CreateIndexes < ActiveRecord::Migration
  def up
    add_index :conditions, :id, unique: true
    add_index :diagnosis, :id, unique: true
    add_index :providers, :id, unique: true
    add_index :provider_practices, :id, unique: true
    add_index :network_providers, :id, unique: true
    add_index :cities, :id, unique: true
    add_index :counties, :id, unique: true
    add_index :provider_additional_attributes, :id, unique: true
    add_index :provider_charges, :id, unique: true
    add_index :practice_organizations, :id, unique: true
    add_index :userlogins, :id, unique: true
    add_index :zips, :id, unique: true
    add_index :provider_networks, :id, unique: true
  end

  def down
    remove_index :conditions
    remove_index :diagnosis
    remove_index :providers
    remove_index :provider_practices
    remove_index :network_providers
    remove_index :cities
    remove_index :counties
    remove_index :provider_additional_attributes
    remove_index :provider_charges
    remove_index :practice_organizations
    remove_index :userlogins
    remove_index :zips
    remove_index :provider_networks
  end
end
