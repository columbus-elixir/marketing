# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     CbusElixir.Repo.insert!(%CbusElixir.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias CbusElixir.Repo
alias CbusElixir.App.Meeting

start = Timex.beginning_of_month(Timex.now)


Enum.each(0..100, fn(x) ->
  date = Timex.shift(start, months: x)
  days = Enum.find(0..6, fn d -> Timex.shift(date, days: d) |> Date.day_of_week() == 2 end)
  meeting_date = Timex.shift(date, days: days)

  %Meeting{}
  |> Meeting.changeset(%{date: meeting_date})
  |> Repo.insert!
end)

users = [
  %{email: "jane.doe@example.com", password: "password"},
  %{email: "john.smith@example.org", password: "password"}
]

for user <- users do
  {:ok, _} = CbusElixir.Accounts.create_user(user)
end
