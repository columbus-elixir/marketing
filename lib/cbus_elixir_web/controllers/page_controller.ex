defmodule CbusElixirWeb.PageController do
  use CbusElixirWeb, :controller

  alias CbusElixir.App.Meetings

  def index(conn, params) do
    next_meeting = Meetings.next_meeting(parse_meeting_date(params["date"]))
    render conn, "index.html", next_meeting: next_meeting
  end

  defp parse_meeting_date(nil), do: Timex.today()

  defp parse_meeting_date(date) do
    date
    |> Date.from_iso8601() 
    |> case do
      {:ok, result} -> result
      {:error, _ } -> Timex.today()
    end
  end

end
