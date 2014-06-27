class ProviderController < ApplicationController
  def index
    provider_ids = ProviderCharge.where("condition_procedure_id = ?",params["selectedPro"]).pluck(:provider_id)
    provider = Provider.where("id IN (?)",provider_ids).select(:img_url,:first_name,:physician_since,:provider_address,:provider_type)
    render :json => provider
  end
end
