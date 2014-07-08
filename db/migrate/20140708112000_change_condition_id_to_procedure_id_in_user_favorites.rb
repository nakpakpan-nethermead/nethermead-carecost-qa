class ChangeConditionIdToProcedureIdInUserFavorites < ActiveRecord::Migration
  def up
	rename_column :user_favorites, :condition_id, :procedure_id
  end
end
