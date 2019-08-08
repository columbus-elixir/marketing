defmodule CbusElixirWeb.Router do
  use CbusElixirWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", CbusElixirWeb do
    # Use the default browser stack
    pipe_through(:browser)

    get("/", PageController, :index)
    get("/registration", MeetingRegistrationController, :index)
    get("/videos", VideoController, :index)

    resources("/meetings", MeetingController)
    resources("/speakers", SpeakerController)
    resources("/attendee", AttendeeController, only: [:new, :create])
  end

  # Other scopes may use custom stacks.
  # scope "/api", CbusElixirWeb do
  #   pipe_through :api
  # end
end
