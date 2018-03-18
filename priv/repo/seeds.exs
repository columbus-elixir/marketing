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

start = Timex.beginning_of_month(Timex.now)


Enum.each(0..10, fn(x) ->
  date = Timex.shift(start, months: x)
  days = Enum.find(0..6, fn d -> Timex.shift(date, days: d) |> Date.day_of_week() == 2 end)
  meeting_date = Timex.shift(date, days: days)
  speaker = %{ email: Faker.Internet.email, name: Faker.Name.name, title: Faker.Name.title, url: Faker.Internet.url }


  changeset = %Meeting{}
    |> Meeting.changeset(%{date: meeting_date})

    case Repo.insert(changeset) do
      {:ok, meeting } ->
        changeset = meeting
          |> Ecto.build_assoc(:speakers)
          |> Speaker.changeset(speaker)

          case Repo.insert(changeset) do
            {:ok, speaker } ->
              IO.inspect("Speaker was added")
            {:error, _reason} ->
              IO.puts("Speaker was not added")
          end
      {:error, _reason} ->
        IO.puts("Meeting was added")
    end

end)
