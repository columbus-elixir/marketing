defmodule CbusElixirWeb.PageController do
  use CbusElixirWeb, :controller

  alias CbusElixir.App.Meetings
  alias CbusElixirWeb.DateParser

  def index(conn, params) do
    next_meeting =
      params["date"]
      |> DateParser.parse_meeting_date(Timex.today())
      |> Meetings.next_meeting()

    render(conn, "index.html", next_meeting: next_meeting)
  end
end
