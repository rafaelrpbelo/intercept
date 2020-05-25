defmodule Intercept.ConnFormatter do
  @moduledoc """
  This module provides a pretty format for incoming %Plug.Conn{},
  then enables humans to read the output easily.
  """

  defmodule InvalidInput do
    defexception message: "A %Plug.Conn{} must be given"
  end

  defmodule ParseBodyError do
    defexception message: "Error while parsing request body"
  end

  def format(%Plug.Conn{} = conn) do
    conn
      |> fetch_body
      |> Map.from_struct
      |> Enum.reject(&skip_attributes(&1))
      |> Enum.map_join("\n", &(format_key_values(&1)))
  end

  def format(_) do
    raise Intercept.ConnFormatter.InvalidInput
  end

  @skip_attributes [ :adapter ]

  defp skip_attributes({key, _value}) do
    if key in @skip_attributes, do: true, else: false
  end

  defp format_key_values({:req_headers, values}) when is_list(values) do
    Enum.map_join(values, "\n", fn {header, value} -> "req_headers[#{header}] => #{value}" end)
  end
  defp format_key_values({key, value}) do
    "#{key} => #{inspect(value)}"
  end

  defp fetch_body(%Plug.Conn{body_params: %Plug.Conn.Unfetched{}} = conn) do
    conn
    |> Plug.Conn.read_body
    |> case do
      {:ok, body, _} -> %{conn | body_params: body}
      _ -> raise ParseBodyError
    end
  end
  defp fetch_body(%Plug.Conn{} = conn), do: conn
  defp fetch_body(_), do: raise ParseBodyError
end
