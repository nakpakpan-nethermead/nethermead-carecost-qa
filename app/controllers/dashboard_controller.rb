class DashboardController < ApplicationController
	def create
		
	end

  def get_suggestions
    condition_array = Array.new

    searchProcedure = params['procedure']
    searchDiagnosis = params['diagnosis']

    if(searchDiagnosis == 'true')
      conditions = Condition.where("consumer_name ILIKE '%#{params[:q]}%' and condition_type='diagnosis'").includes(:procedures)
      condition_array.concat(procedureList(conditions,'d'));
    end
      
    if(searchProcedure == 'true')
      conditions = Condition.where("consumer_name ILIKE '%#{params[:q]}%' and condition_type='procedure'").includes(:procedures)
      condition_array.concat(procedureList(conditions,'p'));
    end

    render :json => condition_array
  end

  def procedureList(conditions,condition_type)
    condition_array_tosend = Array.new

    conditions.each do |c|
      c.procedures.each do |p|
        element = Hash.new
        if c.consumer_name != ''
          if(condition_type == 'd')
            element[:category] = "Diagnosis: #{c.consumer_name}"
          else
            element[:category] = c.consumer_name
          end
          element[:name] =  p.short_name
          element[:id] = p.id
          condition_array_tosend << element
        end
      end
    end
    return condition_array_tosend
  end

  def email_share
    recipient = params["email"]
    subject = "Test Mail"
    message = params["message"]
    @procedures = JSON.parse(params["procedures"])
    Emailer.contact(recipient, subject, @procedures, message).deliver
    return if request.xhr?
    # binding.pry
    render :json => 1
  end


end
