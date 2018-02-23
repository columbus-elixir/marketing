require IEx

defmodule CbusElixirWeb.PageView do
  import Ecto.Query, only: [from: 2]
  use CbusElixirWeb, :view

  alias CbusElixir.Repo
  alias CbusElixir.App.Meeting

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

  def get_next_meeting() do
    today = Timex.today()
    meeting = Repo.one!(from m in Meeting,
      where: m.date > type(^today, Ecto.Date),
      order_by: [asc: m.date],
      limit: 1,
      select: m.date)
    meeting
  end

  def get_meeting_speakers() do
    today = Timex.today()
    meeting = Repo.one!(from m in Meeting,
      where: m.date > type(^today, Ecto.Date),
      order_by: [asc: m.date],
      preload: [:speakers],
      limit: 1)
    meeting
  end

  def formated_date(date) do
    Timex.to_date(date) |> Date.to_string
  end

  defp md5_hash(email) do
    :crypto.hash(:md5, email)
  end

end
