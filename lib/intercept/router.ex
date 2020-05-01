defmodule Intercept.Router do
  use Plug.Router

  alias Intercept.ConnFormatter

  plug :match
  plug Plug.Logger, log: :info
  plug :dispatch

  match _ do
    body = ConnFormatter.format(conn)

    send_resp(conn, 200, body)
  end
end
