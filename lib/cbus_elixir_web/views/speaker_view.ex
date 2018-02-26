defmodule CbusElixirWeb.SpeakerView do
  use CbusElixirWeb, :view
  alias CbusElixir.App.Meetings

  def meeting_options() do
    Timex.today()
    |> Meetings.upcoming_meetings_for()
    |> Enum.map(&{formatted_date(&1.date), &1.id})
  end
end
