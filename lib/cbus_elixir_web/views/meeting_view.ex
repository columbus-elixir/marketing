defmodule CbusElixirWeb.MeetingView do
  use CbusElixirWeb, :view
  alias CbusElixirWeb.MeetingView

  def render("index.json", %{meetings: meetings}) do
    %{data: render_many(meetings, MeetingView, "meeting.json")}
  end

  def render("show.json", %{meeting: meeting}) do
    %{data: render_one(meeting, MeetingView, "meeting.json")}
  end

  def render("meeting.json", %{meeting: meeting}) do
    %{id: meeting.id,
      location: meeting.location,
      address: meeting.address,
      date: meeting.date}
  end
end
