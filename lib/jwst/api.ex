defmodule Jwst.Api do

  use HTTPoison.Base

  
  @endpoint System.get_env("JWST_API_URL") || "https://api.jwstapi.com"

  # Constant for headers
  @headers [{"content-type", "application/json"}] 
  @api_key_header "X-API-KEY"

  @moduledoc """
  Documentation for `JwstApi`.
  """

  @doc """
  Provides an abstraction in front of jwstapi.com

  ## Examples

    iex> Jwst.Api.get_program_list("api_key")

  """

  def process_url(url) do
    @endpoint <> url
  end


  def get_program_list(api_key) do
    __MODULE__.get("/program/list", [{@api_key_header, api_key} | @headers], [])
  end

end
