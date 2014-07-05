class ProviderController < ApplicationController
  def index
    provider_charge = ProviderCharge.where("condition_procedure_id = ?",params["selectedPro"]).pluck(:provider_id, :service_charge)
    provider_ids = Array.new
    provider_charge.each do |charge|
      provider_ids << charge[0]
    end
    provider = Provider.where("id IN (?)",provider_ids).select(:img_url,:first_name,:physician_since,:provider_address,:provider_type,:id)
    index = 0
    provider.each do |prov|
      provider_charge.each do |charge|
       
      end
    end
    #binding.pry
    render :json => provider
  end
end
