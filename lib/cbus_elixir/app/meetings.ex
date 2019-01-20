defmodule CbusElixir.App.Meetings do
  @moduledoc """
  Domain operations for meetings.
  """

  import Ecto.Query

  alias CbusElixir.Repo
  alias CbusElixir.App.Meeting
  alias CbusElixir.Pagination
  alias CbusElixir.App.Speaker
  alias CbusElixir.App.Attendee

  @doc """
  Fetch a paged result for meetings
  """
  def meetings_for_page(page \\ 1, per_page \\ 5)

  @spec meetings_for_page(integer(), integer()) :: map()
  def meetings_for_page(page, per_page) do
    query =
      from(m in Meeting,
        join: s in assoc(m, :speakers),
        where: m.date < ^DateTime.utc_now(),
        order_by: [desc: m.date],
        preload: [speakers: s]
      )

      Pagination.paginate(query, page, per_page)
  end


  def attendees_for_meeting(id) do
    query = 
      from(a in Attendee,
        where: a.meeting_id == ^id,
        select: a.name
      )

    query
    |> Repo.all()
  end

  def attendees_for_meetings(id) do
    query = 
      from(m in Meeting,
        join: a in assoc(m, :attendees),
        where: m.id == ^id,
        preload: [attendees: a]
      )

    query
    |> Repo.all()
  end

  @doc """
  Returns the next `count` upcoming meetings
  """
  def upcoming_meetings(date, count: count) do
    Meeting
    |> Meeting.happening_after(date)
    |> limit(^count)
    |> Repo.all()
  end

  @doc """
  Returns the next upcoming meeting including speakers
  """
  def next_meeting(date) do
    Meeting
    |> Meeting.happening_after(date)
    |> first
    |> Repo.one!()
    |> Repo.preload([:speakers, :attendees])
  end
end




