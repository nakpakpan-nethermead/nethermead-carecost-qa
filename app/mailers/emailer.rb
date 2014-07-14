class Emailer < ActionMailer::Base
  default from: "herokuda@gmail.com"

  def contact(recipient, subject, message)
  	  attachments['procedures.txt'] = File.read('/home/zero/project_nethermead/my_pro/clear_cost_14714/tmp/Procedures/procedures.txt')
      mail(to: recipient, subject: subject, body: message)
   end

end
