defmodule Intercept.ConnFormatterTest do
  use ExUnit.Case, async: true

  alias Intercept.ConnFormatter

  defp default_conn() do
    %Plug.Conn{host: "www.test.com.br"}
    |> Plug.Adapters.Test.Conn.conn("GET", "/asdf", "")
  end

  test ".format receives a %Plug.Conn{}" do
    assert ConnFormatter.format(default_conn())
  end

  test ".format raises InvalidInput if other argument is given" do
    assert_raise ConnFormatter.InvalidInput, "A %Plug.Conn{} must be given", fn ->
      ConnFormatter.format("something")
    end
  end

  test ".format returns a string with Plug.Conn's content" do
    formatted_body = default_conn() |> ConnFormatter.format

    matches = [
      ~r/request_path => "\/asdf"/,
      ~r/method => "GET"/,
      ~r/host => "www.test.com.br"/,
    ]

    for match <- matches do
      assert String.match?(formatted_body, match)
    end
  end
end
