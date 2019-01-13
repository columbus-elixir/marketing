defmodule CbusElixirWeb.MeetingController do
  use CbusElixirWeb, :controller

  alias CbusElixir.App.Meetings
  alias CbusElixir.Repo

  def index(conn, _params) do
    meetings = Meetings.list_meetings() |> Repo.preload([:speakers, :attendees])

    render(conn, "index.html", meetings: meetings)
  end

end