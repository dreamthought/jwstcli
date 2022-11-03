defmodule JwstCli.App do
  require JwstCli.Repl.Executor
  require Logger
  use Application

  def main(args) do
        options = [switches: [single: :boolean, command: :string], aliases: [s: :single]]
    {opts, _, _} = OptionParser.parse(args, options)
    Logger.info inspect opts, label: "Arguments"
    Logger.info inspect opts[:command], label: "Command"
    Logger.info inspect opts[:single], label: "Single command flag"

    isSingle = opts[:single] || false
    command = opts[:command]

    # single invocation
    #JwstCli.Repl.Executor.start :single, api_key, opts[:command]
    if command && isSingle do
      Logger.info "Calling genserver"
      GenServer.call(JwstCli.Repl.Executor, {:execute, command})
      Logger.info "Called genserver"
    else
      #start_opt(api_key)
    end

  end

  @impl true
  def start(_type, _args) do
    api_key = System.get_env("JWST_API_KEY") || Application.fetch_env!(:jwst_cli, :jwst_api_token)

    unless api_key do
      raise "You must set the JWST_API_KEY via config or pass in an environment variable"
    end

    start_state = %{ api_key: api_key }

    children = [
      {JwstCli.Repl.Executor, [start_state]}
    ]
    Logger.info "Using Children"
    Logger.info inspect children, pretty: true
    #Supervisor.start_link(children, [:one_for_one, name: JwstCli.Supervisor])
    #Supervisor.start_link(alt_children, [:one_for_one, name: JwstCli.Supervisor])
    supervisor_response = Supervisor.start_link(children, strategy: :one_for_one)
    {:ok, pid} = supervisor_response
    Logger.info "Start on #{inspect pid}"
    Logger.info Supervisor.count_children(pid)
    main(System.argv())
    supervisor_response
  end

  def init do
    Logger.info "In init"
    main(System.argv())
  end

end
