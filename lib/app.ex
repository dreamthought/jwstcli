defmodule Jwst.App do
  def main(args) do
        options = [switches: [verbose: :boolean], aliases: [v: :verbose]] 
    {opts, _, _} = OptionParser.parse(args, options)
    IO.inspect opts, label: "Arguments"
  end
end
