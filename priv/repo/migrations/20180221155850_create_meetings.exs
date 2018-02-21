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
    Timex.shift(start, days: days)
  end

  start = Timex.now
  Enum.each(0..100, fn(i) ->
    date = Timex.shift(start, months: i)
    CbusElixir.Repo.insert(CbusElixir.App.Meeting, %{date: next_meeting(date)})
  end)

end
