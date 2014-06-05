class RenameCloumnTypeInCondition < ActiveRecord::Migration
  def change
    rename_column :conditions, :type, :condition_type
  end
end
