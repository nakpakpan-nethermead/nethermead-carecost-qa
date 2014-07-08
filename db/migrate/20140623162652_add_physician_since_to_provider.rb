class AddPhysicianSinceToProvider < ActiveRecord::Migration
  def change
    add_column :providers, :physician_since, :string
  end
end
