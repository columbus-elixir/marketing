use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :cbus_elixir, CbusElixirWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :cbus_elixir, CbusElixir.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "cbus_elixir_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :cbus_elixir,
  cbus_auth_config: [
    username: "SecretUser",
    password: "SecretPassword"
  ]
