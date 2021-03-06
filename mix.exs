defmodule Intercept.MixProject do
  use Mix.Project

  def project do
    [
      app: :intercept,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Intercept.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:plug_cowboy, "~> 2.2.1"},
      {:bamboo, "~> 1.4"},
      {:bamboo_smtp, "~> 2.1.0"},
    ]
  end
end
