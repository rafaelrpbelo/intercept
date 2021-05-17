import Config

config :intercept, Intercept.Email,
  from: System.get_env("INTERCEPT_MAIL_FROM", "no-reply@intercept.default"),
  to: System.get_env("INTERCEPT_MAIL_TO"),
  subject_prefix: System.get_env("INTERCEPT_MAIL_SUBJECT_PREFIX", "[INTERCEPT]")

config :intercept, Intercept.Mailer,
  adapter: Bamboo.SendGridAdapter,
  api_key: System.get_env("SENDGRID_API_KEY")
