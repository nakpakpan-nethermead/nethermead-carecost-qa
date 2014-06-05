class AddAutoincrementIndex < ActiveRecord::Migration
  def self.up
  	change_column :conditions, :id, :integer, :null => false, :auto_increment => true
  	change_column :diagnosis, :id, :integer, :null => false, :auto_increment => true
  	change_column :providers, :id, :integer, :null => false, :auto_increment => true
  	change_column :provider_practices, :id, :integer, :null => false, :auto_increment => true
  	change_column :network_providers, :id, :integer, :null => false, :auto_increment => true
  	change_column :cities, :id, :integer, :null => false, :auto_increment => true
  	change_column :counties, :id, :integer, :null => false, :auto_increment => true
  	change_column :provider_additional_attributes, :id, :integer, :null => false, :auto_increment => true
  	change_column :provider_charges, :id, :integer, :null => false, :auto_increment => true
  	change_column :practice_organizations, :id, :integer, :null => false, :auto_increment => true
  	change_column :userlogins, :id, :integer, :null => false, :auto_increment => true
  	change_column :zips, :id, :integer, :null => false, :auto_increment => true
  	change_column :provider_networks, :id, :integer, :null => false, :auto_increment => true
  end
end
