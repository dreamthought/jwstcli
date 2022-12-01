defmodule JwstCli.Downloader do
  use GenServer
  require Logger

  @me __MODULE__

  @start_state %{
    "download_count" => 0,
  }


  @moduledoc """
  Documentation for `JwstCli`.
  """

  @doc """
  GenServer.init/1
  """
  def init(state) do
    {:ok, state}
  end

  def start_link(opts \\  [@start_state]) do
    Logger.info inspect opts, label: "Downloader start_link invoked"
    [state] = opts
    # use @start_state as defaults, even if a state wasn't provided
    initial_state = Map.merge(@start_state, state)
    GenServer.start_link(__MODULE__, initial_state, name: __MODULE__)
  end

  @doc """
  GenServer.handle_call/3 callback for the following signals calls:
    - :execute - Process Command
  """
  def handle_cast({:url, url, :path, path}, state) do
    Logger.info inspect url, label: "URL"
    Logger.info inspect path, label: "Path"
    {:ok, resp} = :httpc.request(:get, {url, []}, [ssl: [verify: :verify_none]], [body_format: :binary] )
    {{_, 200, 'OK'}, _headers, body} = resp
    [_, file_name] = Regex.run(~r/^.*\/([^ \/]+)$/, url)
    local_file_path = path <>  "/" <> file_name
    Logger.info inspect local_file_path, label: "local file path"
    File.write!(local_file_path, body)

    {:noreply, state}
  end


end
