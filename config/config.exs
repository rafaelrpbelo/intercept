import Config

config :intercept, port: 5000

import_config "#{Mix.env()}.exs"
