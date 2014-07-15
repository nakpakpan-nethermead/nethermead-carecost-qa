class ProcedureController < ApplicationController

  def price
    dataBack = []
    if(params['procedures'])

      procedures = JSON.parse(params['procedures'])
      cities = JSON.parse(params['cities'])
      dataBack = []
      
      #If HASH , TODO : Proper Check
      if procedures[0].nil?
        p = procedures
        procedures = []
        procedures << p
      end
      procedures.each do |procedure|
        sendBack = Hash.new
        sendBack["id"] = procedure["id"]
        sendBack["name"] = procedure["name"]
        sendBack["current_network"] = procedure["current_network"]
        sendBack["current_facility"] = procedure["current_facility"]
        sendBack["all_networks"] = procedure["all_networks"]
        sendBack["all_facilities"] = procedure["all_facilities"]
      
        charges = ProviderCharge
            .where(:condition_procedure_id => procedure["id"], 
                   :service_network_type => procedure["current_network"] , 
                   :service_place => procedure["current_facility"])
            .order(:service_charge)

        if (charges[0])
          sendBack["avgCharge"] = charges[0].service_charge
        else
          sendBack["avgCharge"] = 0
        end
        
        sendBack["charge"] = []

        cities.each do |city|
          charges = ProviderCharge
            .where(:condition_procedure_id => procedure["id"], 
                   :service_network_type => procedure["current_network"] , 
                   :service_place => procedure["current_facility"],
                   "#{city['dataType']}" => "#{city['data']}")
            .order(:service_charge)
          price = Hash.new
          if (charges[0])
            price["val"] = charges[0].service_charge
            price["originalVal"] = charges[0].service_charge
          else
            price["val"] = 0
            price["originalVal"] = 0
          end

          sendBack["charge"] << price
        end
    
        dataBack << sendBack
      end
      render :json => dataBack
    end

    # TEMP Code need to be removed
    if(!params['procedures'])
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
  end

  def get_city_suggestions

    condition_array = Array.new

    pincodes = ProviderCharge.where("service_zip_code ILIKE '%#{params[:term]}%'").limit(10).select(:service_city,:service_state,:service_zip_code)
    pincodes.each do |c|
      element = Hash.new
      element[:state] = c.service_state
      element[:category] = "ZipCode"
      element[:originalCat] = "service_zip_code"
      element[:label] = "#{c.service_city}, #{c.service_state} , #{c.service_zip_code}"
      element[:name] = c.service_zip_code
      element[:id] = c.service_zip_code
      condition_array << element
    end

    cities = ProviderCharge.where("service_city ILIKE '%#{params[:term]}%'").limit(10).select(:service_city,:service_state,:service_zip_code)
    cities.each do |c|
      element = Hash.new
      element[:state] = c.service_state
      element[:category] = "City"
      element[:originalCat] = "service_city"
      element[:label] = "#{c.service_city}, #{c.service_state} , #{c.service_zip_code}"
      element[:name] = c.service_city
      element[:id] = c.service_zip_code
      condition_array << element
    end

    states = ProviderCharge.where("service_state ILIKE '%#{params[:term]}%'").limit(10).select(:service_state)
    states.each do |c|
      element = Hash.new
      element[:state] = c.service_state
      element[:category] = "State"
      element[:originalCat] = "service_state"
      element[:label] = c.service_state
      element[:name] = c.service_state
      element[:id] = c.service_state
      condition_array << element
    end

    render :json => condition_array.uniq{|x| x}
  end

  def fav_list
    puts "SSSSSSSSSSSSSS"
  end

end
