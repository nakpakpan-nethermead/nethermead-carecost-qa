class ProcedureController < ApplicationController

  def price
    allCharges = ProviderCharge
        .where(:condition_procedure_id => params[:id])
        .order(:service_charge)
    
    service_network_type = allCharges.map {|a| a.service_network_type}.uniq
    service_place = allCharges.map {|a| a.service_place}.uniq

    if(params["service_network_type"])
      current_network_type = params["service_network_type"]
      current_place = params["service_place"]
    else
      current_network_type = service_network_type[0]
      current_place = service_place[0]
    end
    
    charges = ProviderCharge
      .where(:condition_procedure_id => params[:id], :service_network_type => current_network_type , :service_place => current_place)
      .order(:service_charge)

    if (charges[0])
      price = charges[0].service_charge
    else
      price = 0
    end
    
    sendBack = Hash.new
    sendBack["id"] = params[:id]
    sendBack["name"] = Procedure.find(params[:id]).full_name
    sendBack["charge"] = price
    sendBack["service_place"] = current_place
    sendBack["service_network_type"] = current_network_type
    sendBack["all_service_place"] = service_place
    sendBack["all_service_network_type"] = service_network_type
    render :json => sendBack
  end
end
