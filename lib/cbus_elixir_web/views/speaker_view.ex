defmodule CbusElixirWeb.SpeakerView do
  import Ecto.Query
  use CbusElixirWeb, :view

  alias CbusElixir.Repo
  alias CbusElixir.App.Meeting

  def get_meetings do
    today = Timex.today()
    # meets = CbusElixir.Repo.all(from m in "meetings", 
    #   where: m.date > type(^today, Ecto.Date),
    #   limit: 5,
    #   select: {m.id, m.date})

    meets = Columbus.Repo.all(from m in Meeting,
      where: m.date > type(^today, Ecto.Date),
      order_by: [asc: m.id],
      limit: 5,
      select: {m.id, m.date}
    )
    meetings = for {k, v} <- meets, do: {Timex.to_date(v) |> Date.to_string, k}
  end

end