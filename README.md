![Columbus Elixir Logo](/assets/static/images/cbus_elixir_logo_new.png)


## Getting Server Started:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate` or `mix ecto.setup` to create, migrate and seed.
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server` or `iex -S mix phx.server` if you want to run within a REPL.
  * Create .env file to run locally with ENV_VARS for [basic_auth](https://github.com/cultivatehq/basic_auth) and add following code to config.exs

  ```
  config :cbus_elixir, cbus_auth_config: [
  username: System.get_env("BASIC_AUTH_USERNAME"),
  password: System.get_env("BASIC_AUTH_PASSWORD")
  ]
  ```

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

### Extra Tools

  * Run `mix credo` to see a list of code analysis suggestions via [Credo](https://github.com/rrrene/credo). NOTE: We are using the defaults Credo provides.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
