defmodule JwstCli.MixProject do
  use Mix.Project

  def project do
    [
      app: :jwst_cli,
      version: "0.1.1",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      escript: [main_module: JwstCli.App],
      deps: deps(),
      description: "GenServer, APIs and CLI and CLI wrapping jwstapi.com which exposes JWST data from MAST",
      package: package(),
      name: "JwstCli",
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
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
    ]
  end

  defp package do
    [
      name: "jwst_cli",
      files: ~w(lib .formatter.exs mix.exs config README* LICENSE*),
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/dreamthought/jwstcli", "CodeBerg" => "https://codeberg.org/Fiq/jwstcli"}
    ]
  end
end
