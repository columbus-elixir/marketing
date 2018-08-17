defmodule CbusElixirWeb.MeetingRegistrationController do
  use CbusElixirWeb, :controller

  alias CbusElixir.App
  plug CbusElixir.Plugs.SetNextMeeting


  def index(conn, _params) do
    next_meeting = conn.assigns.next_meeting
    render(conn, "index.html", next_meeting: next_meeting)
  end

end
