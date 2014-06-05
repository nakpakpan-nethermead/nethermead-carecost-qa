class CreateProviders < ActiveRecord::Migration
  def change
    create_table :providers do |t|
      t.string :first_name
      t.string :last_name
      t.string :designations,  :limit => 50
      t.string :img_url,  :limit => 50
      t.timestamp :physian_since
      t.string :condition_type,  :limit => 50

      t.timestamps
    end
    add_index :providers, :id,                unique: true
  end
end
