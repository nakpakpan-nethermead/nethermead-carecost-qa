class Emailer < ActionMailer::Base
  default from: "herokuda@gmail.com"

  def contact(recipient, subject, message)
  	file_path = Rails.root.join('app', 'assets/pdf/procedures.txt')
  	  attachments['procedures.txt'] = File.read(file_path)
      mail(to: recipient, subject: subject, body: message)
   end

end
