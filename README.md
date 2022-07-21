# JwstCli

A cli wrapper and downloader built around jwstapi.com

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `jwst_cli` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:jwst_cli, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/jwst_cli>.

# Executable

Run the following to generate the jwst_cli executable in the parent directory.

```
mix escript.build
```

# Debt to CleanUp

1. Even though I'm using utf-8 strings, I get: "1st argument: not a bitstring"
