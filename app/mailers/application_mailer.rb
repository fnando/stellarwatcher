class ApplicationMailer < ActionMailer::Base
  default from: "notification@stellarwatcher.com"
  layout "mailer"

  add_template_helper ApplicationHelper
end
