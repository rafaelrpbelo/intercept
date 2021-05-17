import Config

config :intercept, port: System.get_env("PORT", "5000") |> String.to_integer

import_config "#{Mix.env()}.exs"
