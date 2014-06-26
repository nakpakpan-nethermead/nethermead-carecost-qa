class ProviderController < ApplicationController
  def index
    if(params[:selectedPro] != "[]")
      binding.pry
    end

    provider = Provider.all.select(:img_url,:first_name,:physician_since,:provider_address,:provider_type)
    render :json => provider
  end
end
