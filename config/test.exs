import Config

config :logger, level: :error

config :intercept, Intercept.Mailer,
  adapter: Bamboo.TestAdapter

config :intercept, Intercept.Email,
  to: "john@example.com",
  from: "support@myapp.com",
  subject_prefix: "[INTERCEPT]"
