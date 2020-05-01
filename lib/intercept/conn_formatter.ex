defmodule Intercept.ConnFormatter do
  @moduledoc """
  This module provides a pretty format for incoming %Plug.Conn{},
  then enables humans to read the output easily.
  """

  defmodule InvalidInput do
    defexception message: "A %Plug.Conn{} must be given"
  end

  def format(%Plug.Conn{} = conn) do
    conn
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

  defp format_key_values({key, value}) do
    "#{key} => #{inspect(value)}"
  end
end
