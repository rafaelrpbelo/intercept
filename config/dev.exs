import Config

config :intercept, Intercept.Mailer,
  adapter: Bamboo.LocalAdapter

if System.get_env("SMTP_SERVER") do
  config :intercept, Intercept.Mailer,
    adapter: Bamboo.SMTPAdapter,
    server: System.get_env("SMTP_SERVER"),
    port: System.get_env("SMTP_PORT"),
    ssl: false
end
