defmodule Intercept.RouterTest do
  use ExUnit.Case, async: true
  use Plug.Test
  use Bamboo.Test

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
    assert String.match?(response.resp_body, ~r/request_path => "\/asdf"/)
  end

  test "returns conn's properies via email" do
    conn(:get, "/asdf", "") |> Router.call(@init)

    assert_email_delivered_with(
      from: "support@myapp.com",
      to: [nil: "john@example.com"],
      subject: "[INTERCEPT] Got a new notification"
    )
  end

  test "set subject according to the given subject param" do
    conn(:get, "/asdf", [abc: "123", subject: "My subject"])
    |> Router.call(@init)

    assert_email_delivered_with(
      from: "support@myapp.com",
      to: [nil: "john@example.com"],
      subject: "[INTERCEPT] My subject"
    )
  end


  test "GET /robots.txt responds with status 200 and SEO settings" do
    response =
      conn(:get, "/robots.txt", "")
      |> Router.call(@init)

    assert response.status == 200
    assert response.resp_body == "User-agent: *\nDisallow: /"
    assert response.halted == true
  end

  test "GET /favicon.ico returns 404" do
    response =
      conn(:get, "/favicon.ico", "")
      |> Router.call(@init)

    assert response.status == 404
    assert response.resp_body == "Not found"
    assert response.halted == true
  end
end
