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

# Execution

1. Set JWST_API_KEY in your shell. Eg. `export JWST_API_KEY=abcdKitten1234`
2. Run mix release
3. Start the release in iex with `iex ....` or with
```

```

or 

```
daemon
remote
```

# GenServer calls for Querying the API

## {:execute, "get_program_list"}

Enter the following the iex session:

```
GenServer.call(Jwst.Repl.Executor, {:execute, "get_program_list"})
```

# Stand alone session

## Buiding

Run the following to generate the jwst_cli executable in the parent directory.
```
mix escript.build
```

Still in progress - this will be a cli app to query the GenServer session as a connected node.
You could potentially run this by starting iex with `elixir --cookie <common value> and -s script`
I've yet to document this properly.

