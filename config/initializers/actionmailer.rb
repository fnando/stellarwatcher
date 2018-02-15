Rails.env.on(:development) do
  config.action_mailer[:default_url_options] = {
    host: "localhost",
    port: 5000
  }
end

Rails.env.on(:production) do
  config.action_mailer[:default_url_options] = {
    host: "stellarwatcher.com",
    scheme: "https"
  }

  config.action_mailer[:smtp_settings] = {
    user_name: ENV["SENDGRID_USERNAME"],
    password: ENV["SENDGRID_PASSWORD"],
    domain: "stellarwatcher.com",
    address: "smtp.sendgrid.net",
    port: 587,
    authentication: :plain,
    enable_starttls_auto: true
  }
end
