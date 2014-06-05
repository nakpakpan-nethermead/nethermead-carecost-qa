class CreateProviderPractices < ActiveRecord::Migration
  def change
    create_table :provider_practices do |t|
      t.integer :practice_id
      t.integer :provider_id
      t.timestamp :affiliation_since
      t.string :practice_scope,  :limit => 50

      t.timestamps
    end
    add_index :provider_practices, :id,                unique: true
  end
end
