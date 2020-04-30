defmodule Intercept.RouterTest do
  use ExUnit.Case, async: true
  use Plug.Test

  alias Intercept.Router

  @init Router.init([])

  test "GET / returns OK" do
    response =
      conn(:get, "/", "")
      |> Router.call(@init)

    assert response.state == :sent
    assert response.status == 200
  end

  test "POST / returns OK" do
    response =
      conn(:post, "/", "")
      |> Router.call(@init)

    assert response.state == :sent
    assert response.status == 200
  end

  test "PUT / returns OK" do
    response =
      conn(:put, "/", "")
      |> Router.call(@init)

    assert response.state == :sent
    assert response.status == 200
  end

  test "PATCH / returns OK" do
    response =
      conn(:patch, "/", "")
      |> Router.call(@init)

    assert response.state == :sent
    assert response.status == 200
  end

  test "DELETE / returns OK" do
    response =
      conn(:delete, "/", "")
      |> Router.call(@init)

    assert response.state == :sent
    assert response.status == 200
  end

  test "returns conn's properies in response body" do
    response =
      conn(:get, "/asdf", "")
      |> Router.call(@init)

    assert response.status == 200

    expected_content = [
      ~r/request_path => "\/asdf"/,
      ~r/method => "GET"/,
      ~r/host => "www.example.com"/,
    ]

    for content <- expected_content do
      assert String.match?(response.resp_body, content)
    end
  end
end
