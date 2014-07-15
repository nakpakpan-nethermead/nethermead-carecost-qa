class Procedure < ActiveRecord::Base
	require "prawn"
	self.primary_key = 'id'

  belongs_to :condition

  def self.generate_procedure_pdf
    file_path = Rails.root.join('app', 'assets/pdf/hello.pdf')
    Prawn::Document.generate(file_path) do
    text "Hello World!"
  end

  end

end
