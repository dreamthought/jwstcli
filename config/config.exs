import Config

config :jwst_cli, download_path: "/tmp"
config :jwst_cli, jwst_api_token: System.get_env("JWST_API_KEY")
config :jwst_cli, env: config_env()
