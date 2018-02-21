# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :cbus_elixir, ecto_repos: [CbusElixir.Repo]

# Configures the endpoint
config :cbus_elixir, CbusElixirWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Elk89hIEey2E+LQSx/QKHfty6RE/mLggKUNyCJDzz8No5/rjIAJyW3h8TDnXg+Fa",
  render_errors: [view: CbusElixirWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: CbusElixir.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

config :phoenix, :template_engines, haml: PhoenixHaml.Engine

config :ueberauth, Ueberauth.Strategy.Github.OAuth,
  client_id: System.get_env("GITHUB_CLIENT_ID"),
  client_secret: System.get_env("GITHUB_CLIENT_SECRET")

config :ueberauth, Ueberauth,
  providers: [
    github: {Ueberauth.Strategy.Github, [default_scope: "user"]}
  ]
