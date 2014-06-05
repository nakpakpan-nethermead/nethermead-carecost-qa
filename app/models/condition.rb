class Condition < ActiveRecord::Base
	self.primary_key = 'id'

	scope :get_conditions, lambda{
		select(:consumer_name, :codeset).all.map{|con| "#{con.consumer_name}|#{con.codeset}" }.join(',')
	}
end
