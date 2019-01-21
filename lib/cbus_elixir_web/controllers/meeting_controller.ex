defmodule CbusElixirWeb.MeetingController do
  use CbusElixirWeb, :controller

  alias CbusElixir.App.Meetings
  alias CbusElixir.Repo

  def index(conn, params) do
    page = params["page"] || 1
    per_page = params["per_page"] || 5
    
    meetings = Meetings.meetings_for_page(page, per_page)

    render(conn, "index.html", meetings: meetings)
  end

  def show(conn, %{"id" => id}) do
    attendees = Meetings.attendees_for_meeting(id)

    render(conn, "show.html", attendees: attendees)
  end
end