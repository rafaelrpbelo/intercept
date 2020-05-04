defmodule Intercept.Router do
  use Plug.Router

  alias Intercept.ConnFormatter
  alias Intercept.{Mailer, Email}

  plug :match
  plug Plug.Logger, log: :info
  plug :dispatch

  @ignore_paths [
    {:get, "/favicon.ico"},
    {:get, "/robots.txt"},
  ]

  for {verb, path} <- @ignore_paths do
    match path, via: verb do
      send_resp(conn, 404, "Not found") |> halt
    end
  end

  match _ do
    formatted_body = ConnFormatter.format(conn)

    Email.notify(formatted_body) |> Mailer.deliver_now()

    send_resp(conn, 200, formatted_body)
  end
end
