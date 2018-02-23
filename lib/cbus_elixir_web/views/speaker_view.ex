defmodule CbusElixirWeb.SpeakerView do
  import Ecto.Query
  use CbusElixirWeb, :view

  def get_meetings do
    today = Timex.today()
    meets = CbusElixir.Repo.all(from m in "meetings", 
      where: m.date > type(^today, Ecto.Date),
      limit: 5,
      select: {m.id, m.date})
    meetings = for {k, v} <- meets, do: {Timex.to_date(v) |> Date.to_string, k}
  end

end