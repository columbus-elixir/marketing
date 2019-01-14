defmodule CbusElixirWeb.MeetingController do
  use CbusElixirWeb, :controller

  alias CbusElixir.App.Meetings
  alias CbusElixir.Repo

  def index(conn, params) do
    page = params["page"] || 1
    per_page = params["per_page"] || 5

    meetings = Meetings.get_meetings!(:paged, page, per_page)

    render(conn, "index.html", meetings: meetings)
  end

end