class AddColumnDiagnosis < ActiveRecord::Migration
  def change
   add_column :diagnosis, :condition_id, :integer, :limit =>8
  end
end
