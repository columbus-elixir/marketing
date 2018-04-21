defmodule CbusElixir.App.Meetings do
  @moduledoc """
  Domain operations for meetings.
  """

  import Ecto.Query, warn: false

  alias CbusElixir.Repo
  alias CbusElixir.App.Meeting


  @doc """
  Returns the next `count` upcoming meetings
  """
  def upcoming_meetings(date, count: count) do
    Meeting
    |> Meeting.happening_after(date)
    |> limit(^count)
    |> Repo.all
  end

  @doc """
  Returns the next upcoming meeting including speakers
  """
  def next_meeting(date) do
    Meeting
    |> Meeting.happening_after(date)
    |> first
    |> Repo.one!
    |> Repo.preload(:speakers)
  end

  def get_speaker_meeting(speaker_id), do: Repo.get!(Meeting, speaker_id)
end
