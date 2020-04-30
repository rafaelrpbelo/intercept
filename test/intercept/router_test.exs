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
end
