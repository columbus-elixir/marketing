defmodule CbusElixirWeb.PageController do
  use CbusElixirWeb, :controller

  alias CbusElixir.App.Meetings

  def index(conn, _params) do
    next_meeting = Meetings.next_meeting(Timex.today())

    render conn, "index.html", next_meeting: next_meeting
  end

end
