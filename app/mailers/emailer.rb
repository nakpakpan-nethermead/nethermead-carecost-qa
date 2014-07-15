class Emailer < ActionMailer::Base
  default from: "herokuda@gmail.com"

  def contact(recipient, subject, procedures, message)
  	file_path = Rails.root.join('app', 'assets/pdf/procedures.txt')
  	@message = message
  	@procedures = procedures
      mail(to: recipient, subject: subject)
   end

end
