import Config

config :jwst_cli, env: config_env()
config :jwst_cli, jwst_api_token: System.get_env("JWST_API_KEY")
