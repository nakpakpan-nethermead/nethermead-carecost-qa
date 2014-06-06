class DashboardController < ApplicationController
	def index
           session[:category]='-----'
         end

	def create
		@proc_list = Procedure.get_procedure_list(params[:category][:consumer_name]) 
                session[:category]=params[:category][:consumer_name]
		render :index
	end

  def get_suggestions
    result = Condition.joins("LEFT JOIN procedures on conditions.codeset = procedures.codeset where conditions.consumer_name LIKE '#{params[:term].capitalize}%'").select("conditions.*, procedures.*,procedures.id AS p_id")
    condition_array = Array.new
    result.each do |c|
      element = Hash.new
      if c.clinical_name != ''
        element[:category] = c.consumer_name
        element[:label] = c.short_name
        #element[:id] = c.p_id
        condition_array << element
      end
    end
    result = Procedure.where("full_name LIKE '#{params[:term].capitalize}%'")
    result.each do |p|
      element = Hash.new
      if p.full_name != ''
        element[:category] = "Procedures"
        element[:label] = p.full_name
        element[:id] = p.id
        condition_array << element
      end
    end
    render :json => condition_array
  end

	private
end
