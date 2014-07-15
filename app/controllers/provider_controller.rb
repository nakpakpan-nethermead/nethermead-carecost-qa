class ProviderController < ApplicationController
  def index
    if(params[:location])
      columnValue = params[:location].split('(')
      case columnValue[1].chop
      when 'City'
        columnName = 'service_city'
      when 'State'
        columnName = 'service_state'
      when 'ZipCode'
        columnName = 'service_zip_code'
      end
    end
    # provider_charge = ProviderCharge.where("condition_procedure_id = ? AND #{columnName} = ? ",params["selectedPro"],columnValue[0]).pluck(:provider_id, :service_charge)
    provider_charge = ProviderCharge.where("condition_procedure_id = ?",params["selectedPro"]).pluck(:provider_id, :service_charge)
    provider_ids = Array.new
    provider_charge.each do |charge|
      provider_ids << charge[0]
    end
    provider = Provider.where("id IN (?)",provider_ids).select(:img_url,:first_name,:physician_since,:provider_address,:provider_type,:id,:img_url, "img_url as cost")
    index = 0
    provider.each do |prov|
      provider_charge.each do |charge|
        if charge[0]  == prov.id
          provider[index].cost = Hash.new
          provider[index].cost['price'] = charge[1]
          provider[index].cost['originalPrice'] = charge[1]
        end
      end
      index += 1
    end
    render :json => provider
  end

  def makefav
    # binding.pry
    @userfav_check = UserFavorite.where("provider_id IN (?) and user_id IN (?)", params["provider_id"], current_user.id).first
    if @userfav_check == nil 
      user_fav = Hash.new
      user_fav[:user_id] = current_user.id
      user_fav[:provider_id] = params["provider_id"]
      user_fav[:procedure_id] = params["procedure_id"]
      user_fav[:date_added] = Time.now.strftime("%m/%d/%Y")
      user_fav[:status] = 1
      UserFavorite.create(user_fav)
      resBack = 1
    else
      if (@userfav_check.status == 0)
        @userfav_check.update_attributes(:status => 1)
        resBack = 1
      else
        @userfav_check.update_attributes(:status => 0)
        resBack = 0
      end
    end
    render :text => resBack
  end
end
