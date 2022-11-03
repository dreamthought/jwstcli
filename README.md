# JwstCli

A cli wrapper and downloader built around jwstapi.com

## Author

raf+jwst@dreamthought.com

## Warning and Context

- This is a hobby project which is being used to learn elixir's OTP, whilst scratching an itch to explore
the new [jwstapi.com](jwstapi.com).
- This API is to accompany dreamily staring into nebuli.
- Use with caution.

## Future work

`JwstCli.Api` may get factored out for reuse as a stand alone library, which wraps HTTPoison.

## Tests

Will grow as more API endpoints and the project matures.

# Installation

### Local

1. Clone
2. `mix release`

### Hex (not yet set up)

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `jwst_cli` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:jwst_cli, "~> 0.1.0"}
  ]
end
```

# Documentation

## Generating
Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/jwst_cli>.


## Prod

Let's not go there yet. But do contribute back if you do.



# Execution

1. Set JWST_API_KEY in your shell. Eg. `export JWST_API_KEY=abcdKitten1234`
2. Run mix release
3. As below, start the release in `start_iex`, or with `daemon` and `remote`


## Set JWST_API_KEY

You can obtain a new API key from [jwstapi.com](https://jwstapi.com)

This provided from the environment and baked into the release at build time.
It may be customised per environment using (./config/config.exs)[./config/config.exs] and sibling overides.

Eg.

```bash
  export JWST_API_KEY=abcdKitten1234
```

## Buiding the Release

We simply run `mix release`

```bash
  mix release
Compiling 5 files (.ex)
warning: module attribute @me was set but never used
  lib/jwst_cli/repl/executor.ex:9

Generated jwst_cli app
Release jwst_cli-0.1.0 already exists. Overwrite? [Yn] y
* assembling jwst_cli-0.1.0 on MIX_ENV=dev
* skipping runtime configuration (config/runtime.exs not found)
* skipping elixir.bat for windows (bin/elixir.bat not found in the Elixir installation)
* skipping iex.bat for windows (bin/iex.bat not found in the Elixir installation)

Release created at _build/dev/rel/jwst_cli!
```

## Connecting to the App to query JWST API

As mentioned there are two methods

### Running as a deamon and connecting remotely

This scenario is better suited to a long running scenario where you may want to connect remotely.

#### Start the app as a background daemon

This will leave the GenServer (with supervisor) running in the background


```elixir
   _build/dev/rel/jwst_cli/bin/jwst_cli daemon
```

This does not produce any output.

#### Connect Remotely

Very similar but you pass in `remote`. This pattern allows you abort each iex session, but still connect
back to the same daemon to query the API.

Eg. The following connects and queries the list of JWST program id's:

```elixir
 _build/dev/rel/jwst_cli/bin/jwst_cli remote
Erlang/OTP 25 [erts-13.0.2] [source] [64-bit] [smp:8:8] [ds:8:8:10] [async-threads:1] [jit:ns]

Interactive Elixir (1.13.2) - press Ctrl+C to exit (type h() ENTER for help)
 
iex(jwst_cli@feynman)1> GenServer.call(JwstCli.Repl.Executor, {:execute, "get_program_list"})
[2731, 2732, 2733, 2734]
```

See also: 
[Elixir Mix Release by Example](https://zemuldo.com/blog/elixir-mix-releases-by-example---powerful-and-inbuilt-6129462ad2bd8290436304ca)

## start_iex

This creates a _blocking_ process which will terminate on exit from `iex`.

It also produces greater visibility of logging output from the GenServer.

Eg.

```elixir
  _build/dev/rel/jwst_cli/bin/jwst_cli start_iex
Erlang/OTP 25 [erts-13.0.2] [source] [64-bit] [smp:8:8] [ds:8:8:10] [async-threads:1] [jit:ns]


10:16:22.183 [info]  Using Children

10:16:22.183 [info]  [{JwstCli.Repl.Executor, [%{api_key: "**************"}]}]

10:16:22.183 [info]  [%{api_key: "***************"}]

10:16:22.183 [info]  Start on #PID<0.905.0>

10:16:22.183 [info]  [active: 1, specs: 1, supervisors: 0, workers: 1]
Interactive Elixir (1.13.2) - press Ctrl+C to exit (type h() ENTER for help)
iex(jwst_cli@feynman)1> GenServer.call(JwstCli.Repl.Executor, {:execute, "get_program_list"})
10:16:49.465 [info]  "get_program_list"
10:16:49.466 [debug] Invoking /program/list with *********
10:16:50.605 [info]  [2731, 2732, 2733, 2734]
[2731, 2732, 2733, 2734]``
```

# GenServer calls for Querying the API

Once you're in a session, you can query the GenServer by using `call` with the following general form:

```elixir
iex> GenServer.call(JwstCli.Repl.Executor, {:execute, "<name of operation>"})
```

Operations with names ending in `_raw` will typically return the raw content of the equivalent remote resources
as JSON (wrapped in a JASON.Response).

See below for you choice of operations

## get_program_list

Returns all JWST program ids as an array

Eg. 

```elixir
iex> GenServer.call(JwstCli.Repl.Executor, {:execute, "get_program_list"})
[2731, 2732, 2733, 2734]        
```

## get_program_list_raw

Returns all JWST program ids contained in the response from /program/list 
[defined by the JWST API](https://documenter.getpostman.com/view/10808728/UzQyphjT#14929ed7-0b6a-4966-98d6-3062b74e8e04)

Eg. 

```elixir
GenServer.call(JwstCli.Repl.Executor, {:execute, "get_program_list_raw"})
```

## get_all_jpg

Returns all JWST jpegs URLs from JWST
[defined by the JWST API](https://documenter.getpostman.com/view/10808728/UzQyphjT#a0b2c1b0-d2e7-46b0-bb19-20df18c94f09)

Eg. 

```elixir
GenServer.call(JwstCli.Repl.Executor, {:execute, "get_all_jpg"})
iex(jwst_cli@feynman)6> GenServer.call(JwstCli.Repl.Executor, {:execute, "get_all_jpg"})
```

## get_all_jpg_raw

Returns all JWST jpegs from JWST
[defined by the JWST API](https://documenter.getpostman.com/view/10808728/UzQyphjT#a0b2c1b0-d2e7-46b0-bb19-20df18c94f09)

Eg. 

```elixir
GenServer.call(JwstCli.Repl.Executor, {:execute, "get_all_jpg_raw"})
iex(jwst_cli@feynman)6> GenServer.call(JwstCli.Repl.Executor, {:execute, "get_all_jpg_raw"})

{:ok,
 %HTTPoison.Response{
   body: "{\"statusCode\":200,\"body\":[{\"id\":\"jw02731002001_02107_00004_mirimage_o002_crf_thumb.jpg\",\"observation_id\":\"jw02731002001_02107_00004_mirimage_o002\",\"program\":2731,\"details\":{\"mission\":\"JWST\",\"instruments\":[{\"instrument\":\"FGS\"},{\"instrument\":\"NIRCam\"},{\"instrument\":\"NIRISS\"},{\"instrument\":\"NIRSpec\"},{\"instrument\":\"MIRI\"}],\"suffix\":\"_thumb\",\"description\":\"thumbnail image of the FITS data product\"},\"file_type\":\"jpg\",\"thumbnail\":\"\",\"location\":\"https://stpubdata-jwst.stsci.edu/ero/jw02731/jw02731002001/jw02731002001_02107_00004_mirimage_o002_crf_thumb.jpg\"], ....
   headers: [...],
   request: %HTTPoison.Request{ .... },
   request_url: ....,
   status_code: 200
 }}
```

## get_all_fits_raw

Returns all JWST FITS imagse from JWST
[defined by the JWST API](https://documenter.getpostman.com/view/10808728/UzQyphjT#a0b2c1b0-d2e7-46b0-bb19-20df18c94f09)

Eg. 

```elixir
GenServer.call(JwstCli.Repl.Executor, {:execute, "get_all_fits_raw"})
iex(jwst_cli@feynman)6> GenServer.call(JwstCli.Repl.Executor, {:execute, "get_all_fits_raw"})

{:ok,
 %HTTPoison.Response{
   body: "{\"statusCode\":200,\"body\":[{\"id\":\"jw02731001003_02105_00001_nrca1_i2d.fits\",\"observation_id\":\"jw02731001003_02105_00001_nrca1\",\"program\":2731,\"details\":{\"mission\":\"JWST\",\"instruments\":[{\"instrument\":\"FGS\"},{\"instrument\":\"NIRCam\"},{\"instrument\":\"NIRISS\"},{\"instrument\":\"NIRSpec\"},{\"instrument\":\"MIRI\"}],\"suffix\":\"_i2d\",\"description\":\"exposure/target (L2b/L3): rectified 2D image\"},\"file_type\":\"fits\",\"thumbnail\":\"\",\"location\":\"https://stpubdata-jwst.stsci.edu/ero/jw02731/jw02731001003/jw02731001003_02105_00001_nrca1_i2d.fits\",...
   headers: [...],
   request: %HTTPoison.Request{ .... },
   request_url: ....,
   status_code: 200
 }}
```

## get_all_ecsv_raw

Returns all ecsv file url's from JWST
[defined by the JWST API](https://documenter.getpostman.com/view/10808728/UzQyphjT#a0b2c1b0-d2e7-46b0-bb19-20df18c94f09)

Eg. 

```elixir
GenServer.call(JwstCli.Repl.Executor, {:execute, "get_all_ecsv_raw"})
iex(jwst_cli@feynman)6> GenServer.call(JwstCli.Repl.Executor, {:execute, "get_all_ecsv_raw"})

{:ok,
 %HTTPoison.Response{
   body: "{\"statusCode\":200,\"body\":[{\"id\":\"jw02731-o001_t017_nircam_clear-f444w_cat.ecsv\",\"observation_id\":\"jw02731-o001_t017_nircam_clear-f444w\",\"program\":2731,\"details\":{\"mission\":\"JWST\",\"instruments\":[{\"instrument\":\"FGS\"},{\"instrument\":\"NIRISS\"}],\"suffix\":\"_cat\",\"description\":\"target (L3) : source catalog\"},\"file_type\":\"ecsv\",\"thumbnail\":\"\",\"location\":\"https://stpubdata-jwst.stsci.edu/ero/jw02731/L3/t/jw02731-o001_t017_nircam_clear-f444w_cat.ecsv\"},{\"id\":\"jw02731-o001_t017_nircam_f444w-f470n_cat.ecsv\",\"observation_id\":\"jw02731-o001_t017_nircam_f444w-f470n\",\"program\":2731,\"details\":{\"mission\":\"JWST\",\"instruments\":[{\"instrument\":\"FGS\"},{\"instrument\":\"NIRISS\"}],\"suffix\":\"_cat\",\"description\":\"target (L3) : source catalog\"},\"file_type\":\"ecsv\",\"thumbnail\":\"\",\"location\":\"https://stpubdata-jwst.stsci.edu/ero/jw02731/L3/t/jw02731-o001_t017_nircam_f444w-f470n_cat.ecsv\",...
   headers: [...],
   request: %HTTPoison.Request{ .... },
   request_url: ....,
   status_code: 200
 }}
```

## get_all_json_raw

Returns all json file url's from JWST
[defined by the JWST API](https://documenter.getpostman.com/view/10808728/UzQyphjT#a0b2c1b0-d2e7-46b0-bb19-20df18c94f09)

Eg. 

```elixir
GenServer.call(JwstCli.Repl.Executor, {:execute, "get_all_json_raw"})
iex(jwst_cli@feynman)6> GenServer.call(JwstCli.Repl.Executor, {:execute, "get_all_json_raw"})

{:ok,
 %HTTPoison.Response{
   body: "{\"statusCode\":200,\"body\":[{\"id\":\"jw02731-o001_20220712t165318_image2_317_asn.json\",\"observation_id\":\"jw02731-o001_20220712t165318_image2_317\",\"program\":2731,\"details\":{\"mission\":\"JWST\",\"instruments\":[{\"instrument\":\"FGS\"},{\"instrument\":\"NIRCam\"},{\"instrument\":\"NIRISS\"},{\"instrument\":\"NIRSpec\"},{\"instrument\":\"MIRI\"}],\"suffix\":\"_asn\",\"description\":\"source/target (L3) : association generator\"},\"file_type\":\"json\",\"thumbnail\":\"\",\"location\":\"https://stpubdata-jwst.stsci.edu/ero/jw02731/asn/jw02731-o001_20220712t165318_image2_317_asn.json\"}, ...
   headers: [...],
   request: %HTTPoison.Request{ .... },
   request_url: ....,
   status_code: 200
 }}
```

# Log Levels

The app is currently VERY chatting. You may want to reduce the default log levels; this is on my TODO.

In iex:

```elixir
iex> Logger.configure(level: :error)
```

In the `config/config.exs` 
```elixir
config :logger, level: :error
```

# Stand alone session (WIP)

## Buiding

This is a work in progres and will ulimately provide a more powerful standalone repl.
Run the following to generate the jwst_cli executable in the parent directory.
```elixir
mix escript.build
```

Still in progress - this will be a cli app to query the GenServer session as a connected node.
You could potentially run this by starting iex with `elixir --cookie <common value> and -s script`
I've yet to document this properly.

# Thanks

Thank you to [Kyle Redelinghuys](https://ksred.com/) who has provided the JWST API 




