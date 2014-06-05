module DashboardHelper
	def get_consumer_name(param = nil)
		if param && param[:consumer_name]
			return param[:consumer_name]
		end
	end
end
