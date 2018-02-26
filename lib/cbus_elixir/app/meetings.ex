defmodule CbusElixir.App.Meetings do
  @moduledoc """
  Domain operations for meetings.
  """

  import Ecto.Query, warn: false
  alias CbusElixir.Repo

  alias CbusElixir.App.Meeting

  @doc """
  Returns the next 5 upcoming meetings
  """
  def upcoming_meetings_for(date) do
    Meeting
    |> Meeting.happening_after(date)
    |> limit(5)
    |> Repo.all
  end

  @doc """
  Returns the next upcoming meeting including speakers
  """
  def next_meeting(date) do
    Meeting
    |> Meeting.happening_after(date)
    |> first
    |> Repo.one
    |> Repo.preload(:speakers)
  end
end
