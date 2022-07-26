defmodule JwstCli.Repl.Executor do
  use GenServer

  require JwstCli.Api
  require JwstCli.CommandDispatcher
  require Logger

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
    - command - Command to invoke
    - args -  Arguments for command
  """
  def handle_call({:execute, command, args}, _from, state) do
    Logger.info inspect command, label: "Handling command"
    Logger.info inspect args, label: "Handling args"
    # TODO - DRY factor out constants
    result = process(state[:api_key], command, args)
    Logger.info inspect result, label: "Response from API"
    Map.update(state, "command_history", [], &([command|&1]))
    {:reply, result, state}
  end

 def handle_call({:execute, command}, _from, state) do
    Logger.info inspect command, label: "Handling command"
    # TODO - DRY factor out constants
    result = process(state[:api_key], command, {})
    Logger.info inspect result, label: "Response from API"
    Map.update(state, "command_history", [], &([command|&1]))
    {:reply, result, state}
  end




  # Client Methods
  @doc """
  Invokes a single command direclty from the commandline

  ## Examples

      iex> JwstCli.Repl.Executor.start(:single, "api_key", "help")
  """
  def start(:single, api_key, command, args \\ {}) do
    process(api_key, command, args) 
  end

  @doc """
  Starts the repl loop to process commands via an interactive and stateful session

  ## Examples

      iex> JwstCli.Repl.Executor.start("api-key")
  """

  def start(api_key) do
    IO.puts("Entering repl" <> api_key)
  end


  @doc false
  defp process(api_key, command, args \\ {}) do
    Logger.info command, label: "Sending command to dispatcher"
    result = JwstCli.CommandDispatcher.dispatch(command, api_key, args)
    Logger.info inspect(result, pretty: true)
    result
  end

end
