defmodule Intercept.Application do
  use Application
  require Logger

  def start(_type, _args) do
    children = [
      {Plug.Cowboy, scheme: :http, plug: Intercept.Plug, options: [port: 5000]}
    ]

    opts = [strategy: :one_for_one, name: Intercept.Supervisor]

    Logger.info("Starting application...")

    Supervisor.start_link(children, opts)
  end
end
