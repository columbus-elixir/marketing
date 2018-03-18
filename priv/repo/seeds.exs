defmodule Seeder do
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


  def run_seeds do
    start = Timex.beginning_of_month(Timex.now)

    Enum.each(0..100, fn(x) ->
      date = Timex.shift(start, months: x)
      days = Enum.find(0..6, fn d -> Timex.shift(date, days: d) |> Date.day_of_week() == 2 end)
      meeting_date = Timex.shift(date, days: days)
      add_meeting(meeting_date)
      end)
  end

  def add_meeting(meeting_date) do
    changeset = %Meeting{}
      |> Meeting.changeset(%{date: meeting_date})

      case Repo.insert(changeset) do
        {:ok, meeting } ->
          IO.puts("Meeting was added")
          (1..3) |> Enum.each(fn(x) ->
            add_speaker(meeting) 
          end)
        {:error, _reason} ->
          IO.puts("Meeting was not added")
      end
  end

  def add_speaker(meeting) do
    changeset = meeting
      |> Ecto.build_assoc(:speakers)
      |> Speaker.changeset(%{email: Faker.Internet.email, name: Faker.Name.name, title: Faker.Name.title, url: Faker.Internet.url})

      case Repo.insert(changeset) do
        {:ok, _speaker } ->
          IO.inspect("Speaker was added")
        {:error, _reason} ->
          IO.puts("Speaker was not added")
      end
  end

end

Seeder.run_seeds()
