# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
   :address => "smtp.gmail.com",
   :port => 587,
   :domain => "clear-cost.herokuapp.com",
   :authentication => :plain,
   enable_starttls_auto: true,
   :user_name => "herokuda@gmail.com",
   :password => "herokuda123",
}