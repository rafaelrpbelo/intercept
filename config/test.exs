import Config

config :logger, level: :error

config :intercept, Intercept.Mailer,
  adapter: Bamboo.TestAdapter
