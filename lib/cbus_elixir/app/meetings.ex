defmodule CbusElixir.App.Meetings do
  @moduledoc """
  Domain operations for meetings.
  """

  import Ecto.Query

  alias CbusElixir.Repo
  alias CbusElixir.App.Meeting
  alias CbusElixir.Pagination
  alias CbusElixir.App.Speaker

  @doc """
  Returns all meetings paginated
  """
  def get_meetings!(:paged, page \\ 1, per_page \\ 5) do
    meeting = list_meetings(:paged, page, per_page)
    speakers = page_of_speakers(meeting, page, per_page)
    Map.put(meeting, :paginated_speakers, speakers)
  end

  def page_of_speakers(meeting, page \\ 1, per_page \\ 5)
  #def page_of_speakers(%Meeting{} = x, y, z), do: page_of_speakers(x.id, y, z)
  def page_of_speakers(meeting_id, page, per_page) do
    Speaker
    #|> where(meeting_id: ^meeting_id)
    |> Pagination.page(page, per_page: per_page)
  end

  def list_meetings(a, page \\ 1, per_page \\ 5)

  def list_meetings(:paged, page, per_page) do
    Meeting
    |> order_by(desc: :date)
    |> Pagination.page(page, per_page: per_page)
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




