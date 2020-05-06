defmodule Intercept.Router do
  use Plug.Router

  alias Intercept.ConnFormatter
  alias Intercept.{Mailer, Email}

  plug :match
  plug Plug.Logger, log: :info
  plug :dispatch

  get "/robots.txt" do
    send_resp(conn, 200, "User-agent: *\nDisallow: /") |> halt
  end

  @ignore_paths [
    {:get, "/favicon.ico"},
  ]
  for {verb, path} <- @ignore_paths do
    match path, via: verb do
      send_resp(conn, 404, "Not found") |> halt
    end
  end

  match _ do
    conn = Plug.Conn.fetch_query_params(conn)
    formatted_body = ConnFormatter.format(conn)

    case conn.params do
      %{"subject" => subject } ->
        Email.notify(formatted_body, subject) |> Mailer.deliver_now()
      %{} ->
        Email.notify(formatted_body) |> Mailer.deliver_now()
    end

    send_resp(conn, 200, formatted_body)
  end
end
