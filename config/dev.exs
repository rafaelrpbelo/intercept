import Config

config :intercept, Intercept.Mailer,
  adapter: Bamboo.LocalAdapter

config :intercept, Intercept.Email,
  from: "support@myapp.com",
  to: "test@me.com"

if System.get_env("SMTP_SERVER") do
  config :intercept, Intercept.Mailer,
    adapter: Bamboo.SMTPAdapter,
    server: System.get_env("SMTP_SERVER"),
    port: System.get_env("SMTP_PORT"),
    ssl: false
end
