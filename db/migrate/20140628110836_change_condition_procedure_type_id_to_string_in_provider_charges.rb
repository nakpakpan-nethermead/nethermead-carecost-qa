class ChangeConditionProcedureTypeIdToStringInProviderCharges < ActiveRecord::Migration
  def change
	change_column :provider_charges, :condition_procedure_type_id, :string
  end
end
