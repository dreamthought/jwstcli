defmodule JwstCli.MixProject do
  use Mix.Project

  def project do
    [
      app: :jwst_cli,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      escript: [main_module: JwstCli.App],
      deps: deps(),
      description: "GenServer, APIs and CLI and CLI wrapping jwstapi.com which exposes JWST data from MAST",
      licenses: "MIT"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: { JwstCli.App, [] },
      extra_applications: [:logger],
      env: []
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 1.8.1"},
      {:exactor, "~> 2.2.4"},
      {:jason, "~> 1.3"},
    ]
  end
end
