defmodule CbusElixirWeb.MeetingRegistrationController do
  use CbusElixirWeb, :controller

  alias CbusElixir.App
  alias CbusElixir.App.{ Meeting, Attendee }

  def index(conn, _params) do

    render(conn, "index.html")
  end

end
