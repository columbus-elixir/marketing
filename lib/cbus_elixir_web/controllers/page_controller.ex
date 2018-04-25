defmodule CbusElixirWeb.PageController do
  use CbusElixirWeb, :controller

  alias CbusElixir.App.Meetings
  alias CbusElixirWeb.DateParser
  alias CbusElixir.App

  def index(conn, params) do

    next_meeting = params["date"]
    |> DateParser.parse_meeting_date(Timex.today())
    |> Meetings.next_meeting()

    speakers = App.list_approved_speakers_by_meeting(next_meeting)
    render conn, "index.html", next_meeting: next_meeting, speakers: speakers
  end

end
