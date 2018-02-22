defmodule CbusElixirWeb.PageController do
  import Ecto.Query, only: [from: 2]
  use CbusElixirWeb, :controller

  alias CbusElixir.Repo
  alias CbusElixir.App.Speaker
  alias CbusElixir.App.Meeting

  def index(conn, _params) do
    today = Timex.today()
    meeting = Repo.all(from m in Meeting, 
      where: m.date > type(^today, Ecto.Date),
      limit: 1,
      select: m.date)
      
    speakers = Repo.all(from s in Speaker,
      join: m in Meeting, 
      where: m.id == s.meeting_id and
        m.date > type(^today, Ecto.Date),
      select: {s.name, s.title, s.email, s.url})

    # speakers = Repo.all(Speaker)
    render conn, "index.html", speakers: speakers, meeting: meeting
  end

end
