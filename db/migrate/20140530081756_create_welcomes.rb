class CreateWelcomes < ActiveRecord::Migration
  def change
    create_table :welcomes do |t|
      t.string :name
      t.string :condition

      t.timestamps
    end
  end
end
