class ProcedureController < ApplicationController

  def price
    allCharges = ProviderCharge
        .where(:condition_procedure_id => params[:id])
        .order(:service_charge)
    
    service_networks = allCharges.map {|a| a.service_network_type}.uniq
    service_facilities = allCharges.map {|a| a.service_place}.uniq

    if(params["current_facility"])
      current_network = params["current_network"]
      current_facility = params["current_facility"]
    else
      current_network = service_networks[0]
      current_facility = service_facilities[0]
    end
    
    charges = ProviderCharge
      .where(:condition_procedure_id => params[:id], 
             :service_network_type => current_network , 
             :service_place => current_facility)
      .order(:service_charge)

    if (charges[0])
      price = charges[0].service_charge
    else
      price = 0
    end
    
    sendBack = Hash.new
    sendBack["id"] = params[:id]
    sendBack["name"] = Procedure.find(params[:id]).full_name
    sendBack["current_network"] = current_network
    sendBack["current_facility"] = current_facility
    sendBack["all_networks"] = service_networks
    sendBack["all_facilities"] = service_facilities

    sendBack["charge"] = []
    sendBack["charge"] << price

    render :json => sendBack
  end

  def get_city_suggestions

    condition_array = Array.new
    cities = ProviderCharge.where("service_city LIKE '%#{params[:term]}%'").limit(10).select(:service_city)
    cities.each do |c|
      element = Hash.new
      element[:category] = "City"
      element[:city] = c.service_city
      element[:state] = c.service_state
      element[:zip] = c.service_zip
      element[:id] = c.service_city
      condition_array << element
    end

    states = ProviderCharge.where("service_state LIKE '%#{params[:term]}%'").limit(10).select(:service_state)
    states.each do |c|
      element = Hash.new
      element[:category] = "State"
      element[:label] = c.service_state
      element[:id] = c.service_state
      condition_array << element
    end

    render :json => condition_array.uniq{|x| x}
  end
end
