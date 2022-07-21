defmodule Jwst.App do
  require Jwst.Cli
  require Logger
  def main(args) do
        options = [switches: [verbose: :boolean, command: :string], aliases: [v: :verbose]] 
    {opts, _, _} = OptionParser.parse(args, options)
    IO.inspect opts, label: "Arguments"
    IO.puts("Processing" <> opts[:command])
    api_key = System.get_env("JWST_API_KEY") || raise "You must set the JWST_API_KEY env vart"
    IO.inspect opts[:command], label: "COmmand"
    Jwst.Cli.start :single, api_key, opts[:command]
  end
end
