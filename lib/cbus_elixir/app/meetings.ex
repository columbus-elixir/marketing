defmodule CbusElixir.App.Meetings do
  @moduledoc """
  Domain operations for meetings.
  """

  import Ecto.Query

  alias CbusElixir.Repo
  alias CbusElixir.App.Meeting

  @doc """
  Returns the next `count` upcoming meetings
  """
  def upcoming_meetings(date, count) do
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

  def find_speaker_meeting_date(speaker_meeting_id) do
    Meetings
    |> where([m], m.meeting_id == speaker_meeting_id)
  end
end
