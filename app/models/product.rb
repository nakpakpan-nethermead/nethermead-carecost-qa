class Product < ActiveRecord::Base
has_many :categorys
	def category_name
	  category.name if category
	end

	def category_name=(name)
	  self.category = Category.find_or_create_by_name(name) unless name.blank?
	end
end
