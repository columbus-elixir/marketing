defmodule CbusElixirWeb.Router do
  use CbusElixirWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug CbusElixir.Plugs.SetCurrentUserName
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", CbusElixirWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/speakers", SpeakerController
  end

  scope "/auth", CbusElixirWeb do
    pipe_through :browser

    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
    post "/:provider/callback", AuthController, :callback
    delete "/logout", AuthController, :delete
  end

  # Other scopes may use custom stacks.
  # scope "/api", CbusElixirWeb do
  #   pipe_through :api
  # end
end
