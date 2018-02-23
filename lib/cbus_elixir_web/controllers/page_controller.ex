defmodule CbusElixirWeb.PageController do
  import Ecto.Query, only: [from: 2]
  use CbusElixirWeb, :controller

  alias CbusElixir.Repo
  alias CbusElixir.App.Speaker
  alias CbusElixir.App.Meeting

  def index(conn, _params) do
    today = Timex.today()
    meeting = Repo.one!(from m in Meeting,
      where: m.date > type(^today, Ecto.Date),
      order_by: [asc: m.date],
      preload: [:speakers],
      limit: 1)
    
    date = Timex.to_date(meeting.date) |> Date.to_string
    
    render conn, "index.html", speakers: meeting.speakers, date: date
  end

end
