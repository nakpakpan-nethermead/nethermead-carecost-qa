class DashboardController < ApplicationController
	def create
		
	end

  def get_suggestions
    condition_array = Array.new

    searchProcedure = params['procedure']
    searchDiagnosis = params['diagnosis']
    if(searchProcedure == 'false' && searchDiagnosis == 'false')
      searchProcedure = 'true'
      searchDiagnosis = 'true'
    end


    if(searchProcedure == 'true')
      result = Condition.joins(
               "INNER JOIN procedures on conditions.code = procedures.code 
                where conditions.consumer_name ILIKE '%#{params[:term]}%' AND conditions.condition_type='procedure' order by conditions.id")
                .select("conditions.id,conditions.consumer_name, procedures.id AS p_id, procedures.short_name")
      result.each do |c|
        element = Hash.new
        if c.consumer_name != ''
          element[:category] = c.consumer_name
          element[:label] = 'Procedure: '+ c.short_name
          element[:id] = c.p_id
          condition_array << element
        end 
      end
    end

    if(searchDiagnosis == 'true')
      result = Condition.joins(
               "INNER JOIN diagnosis on conditions.code = diagnosis.code 
                where conditions.consumer_name ILIKE '%#{params[:term]}%' AND conditions.condition_type='diagnosis' order by conditions.id")
                .select("conditions.id,conditions.consumer_name, diagnosis.id AS d_id, diagnosis.short_name")

      result.each do |d|
        element = Hash.new
        if d.consumer_name != ''
          element[:category] = d.consumer_name
          element[:label] =  d.short_name
          element[:id] = d.d_id
          condition_array << element
        end
      end
    end


    result = Procedure.where("short_name ILIKE '%#{params[:term]}%'")
    result.each do |p|
      element = Hash.new
      if p.full_name != ''
        element[:category] = "Procedures"
        element[:label] = p.full_name
        element[:id] = p.id
        condition_array << element
      end
    end

    # result = Diagnosis.where("short_name LIKE '%#{params[:term]}%'")
    # result.each do |p|
    #   element = Hash.new
    #   if p.full_name != ''
    #     element[:category] = "Procedures"
    #     element[:label] = p.full_name
    #     element[:id] = p.id
    #     condition_array << element
    #   end
    # end

    render :json => condition_array
  end

	private
end
