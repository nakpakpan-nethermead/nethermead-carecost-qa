class ChangeConditionIdToProcedureIdInUserFavorites < ActiveRecord::Migration
  def change
	rename_column :user_favorites, :condition_id, :procedure_id
  end
end
