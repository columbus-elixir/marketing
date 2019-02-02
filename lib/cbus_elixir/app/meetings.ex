defmodule CbusElixir.App.Meetings do
  @moduledoc """
  Domain operations for meetings.
  """

  import Ecto.Query

  alias Ecto
  alias CbusElixir.Repo
  alias CbusElixir.App.Meeting
  alias CbusElixir.Pagination
  alias CbusElixir.App.Speaker
  alias CbusElixir.App.Attendee

  @doc """
  Fetch past meetings
  """

  @spec meetings_for_page_query() :: Ecto.Query.t()
  def meetings_for_page_query() do
    from(m in Meeting,
      left_join: s in assoc(m, :speakers),
      where: m.date < ^DateTime.utc_now(),
      order_by: [desc: m.date],
      distinct: m.date
    )
  end

  @doc """
  Returns the attendees for the given meeting
  """

  @spec attendees_for_meeting(integer()) :: list(Attendee.t())
  def attendees_for_meeting(id) do
    query =
      from(a in Attendee,
        where: a.meeting_id == ^id,
        select: a.name
      )

    query
    |> Repo.all()
  end

  @doc """
  Returns the next `count` upcoming meetings
  """

  @spec upcoming_meetings(integer(), integer()) :: map()
  def upcoming_meetings(date, count: count) do
    Meeting
    |> Meeting.happening_after(date)
    |> limit(^count)
    |> Repo.all()
  end

  @doc """
  Returns the next upcoming meeting including speakers
  """

  @spec next_meeting(integer()) :: map()
  def next_meeting(date) do
    Meeting
    |> Meeting.happening_after(date)
    |> first
    |> Repo.one!()
    |> Repo.preload([:speakers, :attendees])
  end
end
