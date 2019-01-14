defmodule CbusElixirWeb.MeetingController do
  use CbusElixirWeb, :controller

  alias CbusElixir.App.Meetings
  alias CbusElixir.Repo

  def index(conn, params) do
    page = params["page"] || 1
    per_page = params["per_page"] || 5

    meetings = Meetings.list_meetings(:paged, page, per_page) |> Repo.preload([:speakers, :attendees])

    render(conn, "index.html", meetings: meetings)
  end

end