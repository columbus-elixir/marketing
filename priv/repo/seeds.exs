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
  %{first_name: "Matthew", last_name: "Johnson", email: "john.doe@example.com", password: "password"},
  %{first_name: "Admin", last_name: "McAdminson", email: "imaadmin@exampe.com", password: "adminpassword", is_admin: true}
]

for user <- users do
  {:ok, _} = CbusElixir.Accounts.create_user(user)
end
