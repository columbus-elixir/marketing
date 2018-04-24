defmodule CbusElixirWeb.Router do
  use CbusElixirWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Phauxth.Authenticate
    plug Phauxth.Remember
  end

  if Mix.env == :dev do
    forward "/sent_emails", Bamboo.EmailPreviewPlug
  end

  scope "/", CbusElixirWeb do
    pipe_through :browser


    get "/", PageController, :index
    resources "/speakers", SpeakerController
    resources "/users", UserController do
      get "/admin", UserController, :admin, as: :admin
    end
    resources "/sessions", SessionController, only: [:new, :create, :delete]
  end

end
