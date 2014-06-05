class CreateZips < ActiveRecord::Migration
  def change
    create_table :zips do |t|

      t.string :zip_code,  :limit => 50
      t.string :city_name
      t.string :county_name
      t.string :state_code,  :limit => 50

      t.timestamps
    end
    add_index :zips, :id,                unique: true
  end
end
