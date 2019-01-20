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
alias CbusElixir.App.Speaker

start_date = ~N[2018-03-01T00:00:00]

Enum.each(0..100, fn x ->
  date = Timex.shift(start_date, months: x)
  days = Enum.find(0..6, fn d -> Timex.shift(date, days: d) |> Date.day_of_week() == 2 end)
  meeting_date = Timex.shift(date, days: days)

  %Meeting{}
  |> Meeting.changeset(%{date: meeting_date})
  |> Repo.insert!()
end)

%Speaker{}
  |> Speaker.changeset(%{email: "test@test.com", name: "test", title: "test", url: "test.com", meeting_id: 1})
  |> Repo.insert!()

%Speaker{}
  |> Speaker.changeset(%{email: "test@test.com", name: "test", title: "test", url: "test.com", meeting_id: 2})
  |> Repo.insert!()

%Speaker{}
  |> Speaker.changeset(%{email: "test@test.com", name: "test", title: "test", url: "test.com", meeting_id: 3})
  |> Repo.insert!()

%Speaker{}
  |> Speaker.changeset(%{email: "test@test.com", name: "test", title: "test", url: "test.com", meeting_id: 4})
  |> Repo.insert!()

%Speaker{}
  |> Speaker.changeset(%{email: "test@test.com", name: "test", title: "test", url: "test.com", meeting_id: 5})
  |> Repo.insert!()

%Speaker{}
  |> Speaker.changeset(%{email: "test@test.com", name: "test", title: "test", url: "test.com", meeting_id: 6})
  |> Repo.insert!()

%Speaker{}
  |> Speaker.changeset(%{email: "test@test.com", name: "test", title: "test", url: "test.com", meeting_id: 7})
  |> Repo.insert!()

%Speaker{}
  |> Speaker.changeset(%{email: "test@test.com", name: "test", title: "test", url: "test.com", meeting_id: 8})
  |> Repo.insert!()

%Speaker{}
  |> Speaker.changeset(%{email: "test@test.com", name: "test", title: "test", url: "test.com", meeting_id: 9})
  |> Repo.insert!()

%Speaker{}
  |> Speaker.changeset(%{email: "test@test.com", name: "test", title: "test", url: "test.com", meeting_id: 10})
  |> Repo.insert!()

%Speaker{}
  |> Speaker.changeset(%{email: "test@test.com", name: "test", title: "test", url: "test.com", meeting_id: 11})
  |> Repo.insert!()

%Speaker{}
  |> Speaker.changeset(%{email: "test@test.com", name: "test", title: "test", url: "test.com", meeting_id: 12})
  |> Repo.insert!()

%Speaker{}
  |> Speaker.changeset(%{email: "test@test.com", name: "test", title: "test", url: "test.com", meeting_id: 13})
  |> Repo.insert!()

%Speaker{}
  |> Speaker.changeset(%{email: "test@test.com", name: "test", title: "test", url: "test.com", meeting_id: 14})
  |> Repo.insert!()

%Speaker{}
  |> Speaker.changeset(%{email: "test@test.com", name: "test", title: "test", url: "test.com", meeting_id: 15})
  |> Repo.insert!()

%Speaker{}
  |> Speaker.changeset(%{email: "test@test.com", name: "test", title: "test", url: "test.com", meeting_id: 16})
  |> Repo.insert!()
  
%Speaker{}
  |> Speaker.changeset(%{email: "test@test.com", name: "test", title: "test", url: "test.com", meeting_id: 17})
  |> Repo.insert!()

%Speaker{}
  |> Speaker.changeset(%{email: "test@test.com", name: "test", title: "test", url: "test.com", meeting_id: 18})
  |> Repo.insert!()

%Speaker{}
  |> Speaker.changeset(%{email: "test@test.com", name: "test", title: "test", url: "test.com", meeting_id: 19})
  |> Repo.insert!()

%Speaker{}
  |> Speaker.changeset(%{email: "test@test.com", name: "test", title: "test", url: "test.com", meeting_id: 20})
  |> Repo.insert!()

%Speaker{}
  |> Speaker.changeset(%{email: "test@test.com", name: "test", title: "test", url: "test.com", meeting_id: 21})
  |> Repo.insert!()

%Speaker{}
  |> Speaker.changeset(%{email: "test@test.com", name: "test", title: "test", url: "test.com", meeting_id: 22})
  |> Repo.insert!()

%Speaker{}
  |> Speaker.changeset(%{email: "test@test.com", name: "test", title: "test", url: "test.com", meeting_id: 23})
  |> Repo.insert!()

%Speaker{}
  |> Speaker.changeset(%{email: "test@test.com", name: "test", title: "test", url: "test.com", meeting_id: 24})
  |> Repo.insert!()

%Speaker{}
  |> Speaker.changeset(%{email: "test@test.com", name: "test", title: "test", url: "test.com", meeting_id: 25})
  |> Repo.insert!()

%Speaker{}
  |> Speaker.changeset(%{email: "test@test.com", name: "test", title: "test", url: "test.com", meeting_id: 26})
  |> Repo.insert!()

%Speaker{}
  |> Speaker.changeset(%{email: "test@test.com", name: "test", title: "test", url: "test.com", meeting_id: 27})
  |> Repo.insert!()

%Speaker{}
  |> Speaker.changeset(%{email: "test@test.com", name: "test", title: "test", url: "test.com", meeting_id: 28})
  |> Repo.insert!()

%Speaker{}
  |> Speaker.changeset(%{email: "test@test.com", name: "test", title: "test", url: "test.com", meeting_id: 29})
  |> Repo.insert!()

%Speaker{}
  |> Speaker.changeset(%{email: "test@test.com", name: "test", title: "test", url: "test.com", meeting_id: 30})
  |> Repo.insert!()

%Speaker{}
  |> Speaker.changeset(%{email: "test@test.com", name: "test", title: "test", url: "test.com", meeting_id: 31})
  |> Repo.insert!()

%Speaker{}
  |> Speaker.changeset(%{email: "test@test.com", name: "test", title: "test", url: "test.com", meeting_id: 32})
  |> Repo.insert!()
