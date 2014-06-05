class CreateUserlogins < ActiveRecord::Migration
  def change
    create_table :userlogins do |t|
      t.integer :userId
      t.string :password,  :limit => 50
      t.string :status,  :limit => 50

      t.timestamps
    end
    add_index :userlogins, :id,                unique: true
  end
end
