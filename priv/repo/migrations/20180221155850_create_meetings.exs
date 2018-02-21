defmodule CbusElixir.Repo.Migrations.CreateMeetings do
  use Ecto.Migration

  def change do
    create table(:meetings) do
      add :date, :utc_datetime

      timestamps()
    end

  end

  def next_meeting(date \\ nil)
  def next_meeting(date) when is_nil(date), do: next_meeting(Timex.now("America/Chicago"))
  def next_meeting(date) do
    # First Tuesday of each month
    start = Timex.beginning_of_month(date)
    days = Enum.find(0..6, fn d -> Timex.shift(start, days: d) |> Date.day_of_week() == 2 end)
    meeting_date = Timex.shift(start, days: days)

    case Timex.after?(date, meeting_date) do
      false -> Timex.format!(meeting_date, "{YYYY}-{0M}-{0D}")
      true -> next_meeting(Timex.shift(meeting_date, months: 1))
    end
  end

  start = Timex.now
  Enum.with_index(0..100, fn(i) ->
    date = Timex.shift(start, months: i)
    Reop.insert(Meeting, %{date: next_meeting(date)})
  end)

end
