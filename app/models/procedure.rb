class Procedure < ActiveRecord::Base
	self.primary_key = 'id'

  belongs_to :condition

  
end
