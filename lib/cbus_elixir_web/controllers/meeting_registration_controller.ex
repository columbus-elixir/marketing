defmodule CbusElixirWeb.MeetingRegistrationController do
  use CbusElixirWeb, :controller

  alias CbusElixir.App
  alias CbusElixir.App.{ Meetings, Attendee }

  def index(conn, _params) do
    next_meeting = Meetings.next_meeting(Timex.now)
    render(conn, "index.html", next_meeting: next_meeting)
  end

end
