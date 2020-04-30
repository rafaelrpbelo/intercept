defmodule Intercept.Application do
  use Application
  require Logger

  def start(_type, _args) do
    children = [
      {
        Plug.Cowboy,
        scheme: :http,
        plug: Intercept.Router,
        options: [port: application_port()]
      }
    ]

    opts = [strategy: :one_for_one, name: Intercept.Supervisor]

    Logger.info("Starting application...")

    Supervisor.start_link(children, opts)
  end

  defp application_port, do: Application.get_env(:intercept, :port, 5000)
end
