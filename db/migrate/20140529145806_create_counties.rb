class CreateCounties < ActiveRecord::Migration
  def change
    create_table :counties do |t|
      t.string :name
      t.string :state_code,  :limit => 50

      t.timestamps
    end
    add_index :counties, :id,                unique: true
  end
end
