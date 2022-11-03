defmodule JwstCli.Api do

  use HTTPoison.Base
  require Logger

  @endpoint System.get_env("JWST_API_URL") || "https://api.jwstapi.com"

  # Constant for headers
  @headers [{"content-type", "application/json"}]
  @api_key_header "X-API-KEY"

  # valid file types
  @valid_types [:jpg, :ecsv, :fits, :json]

  @moduledoc """
  Documentation for `JwstCli.Api`.

  Provides an abstraction in front of jwstapi.com wrapped in a
  json response See [jason module docs](https://hexdocs.pm/jason/Jason.html)
  """

  def process_url(url) do
    @endpoint <> url
  end

  @doc """
  Provides a list of progamme id's based on MAST data.
  json response See [api docs](https://documenter.getpostman.com/view/10808728/UzQyphjT#14929ed7-0b6a-4966-98d6-3062b74e8e04]3062b74e8e04)

  ## Examples

    iex> [:ok, Jason.response ] = JwstCli.Api.get_program_list("api_key")
  """
  def get_program_list(api_key) do
    Logger.debug "Invoking /program/list"
    __MODULE__.get("/program/list", [{@api_key_header, api_key} | @headers], [])
  end

  @doc """
  Provides an abstraction in front of jwstapi.com wrapped in a
  json response See [jason module docs|https://hexdocs.pm/jason/Jason.html]
  json response See [api docs](https://documenter.getpostman.com/view/10808728/UzQyphjT#14929ed7-0b6a-4966-98d6-3062b74e8e04]3062b74e8e04)

  ## Examples

    iex> [:ok, Jason.response ] = JwstCli.Api.get_program_list("api_key")
  """
  def get_all_by_file_type(api_key, type) do
    unless Enum.member? @valid_types, type do
      Logger.error inspect type, label: "Invalid type passed to get_all_by_file_type"
    end

    Logger.debug "Invoking /all/type/<type> for type #{type}"
    __MODULE__.get("/all/type/#{type}", [{@api_key_header, api_key} | @headers], [])
  end

end
