class CreateUserFavorites < ActiveRecord::Migration
  def change
    create_table :user_favorites do |t|
  	  t.integer :user_id
  	  t.integer :procedure_id
  	  t.integer :provider_id
  	  t.date :date_added
  	  t.integer :status
      t.timestamps
    end
  end
end
