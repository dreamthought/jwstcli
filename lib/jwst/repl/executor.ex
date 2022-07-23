defmodule Jwst.Repl.Executor do
  use GenServer
#  use ExActor.GenServer, export: {:global, __MODULE__}

  require Jwst.Api
  require Jwst.CommandDispatcher
  require Logger

  @me __MODULE__

  @start_state %{
    "api_key" => "Unset - Please Provide",
    "execution_count" => 0,
    "command_history" => [],
  }

  @moduledoc """
  Documentation for `JwstCli`.
  """

  def start_link(opts \\  [@start_state]) do
    Logger.info inspect opts, label: "Executor start_link invoked"
    [state] = opts
    # use @start_state as defaults, even if a state wasn't provided
    initial_state = Map.merge(@start_state, state)
    GenServer.start_link(__MODULE__, initial_state, name: __MODULE__)
  end

  @doc """
  GenServer.init/1
  """
  def init(state) do
    {:ok, state}
  end 

  @doc """
  GenServer.handle_call/3 callback for the following signals calls:
    - :execute - Process Command 
  """
  def handle_call({:execute, command}, _from, state) do
    Logger.info inspect command, label: "Handling command"
    Logger.info inspect state, label: "state"
    # TODO - DRY factor out constants
    result = process(state[:api_key], command)
    Logger.info inspect result, label: "Response from API"
    Map.update(state, "command_history", [], &([command|&1]))
    {:reply, result, state}
  end


  # Client Methods
  @doc """
  Invokes a single command direclty from the commandline

  ## Examples

      iex> Jwst.Repl.Executor.start(:single, "api_key", "help")
  """

  def start(:single, api_key, command) do
    process(api_key, command)
  end

  @doc """
  Starts the repl loop to process commands via an interactive and stateful session 

  ## Examples

      iex> Jwst.Repl.Executor.start("api-key")
  """

  def start(api_key) do
    IO.puts("Entering repl" <> api_key)
  end


  @doc false
  defp process(api_key, command) do
    Logger.info command, label: "Sending command to dispatcher"
    result =Jwst.CommandDispatcher.dispatch(command, api_key)
    Logger.info inspect(result, pretty: true)
    result
  end
    
end
