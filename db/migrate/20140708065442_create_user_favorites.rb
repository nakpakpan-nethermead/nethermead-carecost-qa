class CreateUserFavorites < ActiveRecord::Migration
  def up
	drop_table :user_favorites if table_exists? :user_favorites 
            create_table :user_favorites do |t|
	  t.integer :user_id
	  t.integer :condition_id
	  t.integer :provider_id
	  t.date :date_added

	  t.timestamps
    end
	  add_index :user_favorites, :id, unique: true
  end
end
