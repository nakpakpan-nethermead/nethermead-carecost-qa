class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :name
      t.string :logo_url,  :limit => 50

      t.timestamps
    end
    add_index :clients, :id,                unique: true
  end
end
