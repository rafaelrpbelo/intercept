defmodule Intercept.Router do
  use Plug.Router

  alias Intercept.ConnFormatter
  alias Intercept.{Mailer, Email}

  plug :match
  plug Plug.Logger, log: :info
  plug :dispatch

  match _ do
    formatted_body = ConnFormatter.format(conn)

    Email.notify(formatted_body) |> Mailer.deliver_now()

    send_resp(conn, 200, formatted_body)
  end
end
