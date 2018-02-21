require IEx

defmodule CbusElixirWeb.PageView do
  use CbusElixirWeb, :view

  def gravatar_url(email) do
    hash =
      email
      |> String.trim()
      |> String.downcase()
      |> md5_hash
      |> Base.encode16()
      |> String.downcase()

    "https://www.gravatar.com/avatar/#{hash}"
  end

  # def next_meeting(date \\ nil)
  # def next_meeting(date) when is_nil(date), do: next_meeting(Timex.now("America/Chicago"))
  # def next_meeting(date) do
  #   # First Tuesday of each month
  #   start = Timex.beginning_of_month(date)
  #   days = Enum.find(0..6, fn d -> Timex.shift(start, days: d) |> Date.day_of_week() == 2 end)
  #   meeting_date = Timex.shift(start, days: days)

  #   case Timex.after?(date, meeting_date) do
  #     false -> Timex.format!(meeting_date, "{YYYY}-{0M}-{0D}")
  #     true -> next_meeting(Timex.shift(meeting_date, months: 1))
  #   end
  # end

  defp md5_hash(email) do
    :crypto.hash(:md5, email)
  end
end
