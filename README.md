CircleCI: [![CircleCI](https://circleci.com/gh/columbus-elixir/marketing/tree/master.svg?style=svg)](https://circleci.com/gh/columbus-elixir/marketing/tree/master)

![Columbus Elixir Logo](/assets/static/images/cbus_elixir_logo_new.png)


## Getting Server Started:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate` or `mix ecto.setup` to create, migrate and seed.
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server` or `iex -S mix phx.server` if you want to run within a REPL.
  * Create .env file to run locally with ENV_VARS for [basic_auth](https://github.com/cultivatehq/basic_auth).
  .env should look something like this.
  ```
  #.env
  export BASIC_AUTH_USERNAME=(replace with your login)
  export BASIC_AUTH_PASSWORD=(replace with your password)
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
