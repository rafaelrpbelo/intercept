defmodule Intercept.Router do
  use Plug.Router

  plug :match
  plug :dispatch

  match _ do
    body =
      conn
      |> Map.from_struct
      |> Enum.reject(&skip_attributes(&1))
      |> Enum.map_join("\n", &(format_key_values(&1)))

    send_resp(conn, 200, body)
  end

  @skip_attributes [ :adapter ]

  defp skip_attributes({key, _value}) do
    if key in @skip_attributes, do: true, else: false
  end

  defp format_key_values({key, value}) do
    "#{key} => #{inspect(value)}"
  end
end
