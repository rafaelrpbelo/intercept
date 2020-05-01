defmodule Intercept.ConnFormatterTest do
  use ExUnit.Case, async: true

  alias Intercept.ConnFormatter

  test ".format receives a %Plug.Conn{}" do
    assert ConnFormatter.format(%Plug.Conn{})
  end

  test ".format raises InvalidInput if other argument is given" do
    assert_raise ConnFormatter.InvalidInput, "A %Plug.Conn{} must be given", fn ->
      ConnFormatter.format("something")
    end
  end

  test ".format returns a string with Plug.Conn's content" do
    formatted_body =
      %Plug.Conn{host: "www.test.com.br", request_path: "/asdf", method: "GET"}
      |> ConnFormatter.format

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
