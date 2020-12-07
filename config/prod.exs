import Config

config :intercept, Intercept.Mailer,
  adapter: Bamboo.SendGridAdapter,
  api_key: System.get_env("SENDGRID_API_KEY"),
  to: System.get_env("INTERCEPT_MAIL_TO"),
  from: System.get_env("INTERCEPT_MAIL_FROM", "no-reply@intercept.default"),
  subject_prefix: System.get_env("INTERCEPT_MAIL_SUBJECT_PREFIX", "[INTERCEPT]")
