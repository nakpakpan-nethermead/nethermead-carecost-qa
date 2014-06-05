class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.string :name
      t.string :county,  :limit => 50
      t.string :state_code,  :limit => 50
      t.string :zip_code,  :limit => 50

      t.timestamps
    end
    add_index :cities, :id,                unique: true
  end

  def self.down
    drop_table :cities
  end

end
