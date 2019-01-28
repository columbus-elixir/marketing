defmodule CbusElixir.MeetingsTest do
  use CbusElixir.DataCase

  alias CbusElixir.Repo
  alias CbusElixir.App.Meeting
  alias CbusElixir.App.Meetings
  alias CbusElixir.Pagination

  def create_meeting_for_week(week) when is_integer(week) do
    meeting_date = Timex.shift(~N[2018-01-01T00:00:00], days: week * 7)

    %Meeting{}
    |> Meeting.changeset(%{date: meeting_date})
    |> Repo.insert!()
  end

  def create_eleven_past_meetings() do
    Enum.each(0..10, fn x ->
      date = Timex.shift(~N[2018-03-01T00:00:00], months: x)
      days = Enum.find(0..6, fn d -> Timex.shift(date, days: d) |> Date.day_of_week() == 2 end)
      meeting_date = Timex.shift(date, days: days)
      
      %Meeting{}
      |> Meeting.changeset(%{date: meeting_date})
      |> Repo.insert!()
    end)
  end

  describe "Paginated Meetings" do
    test "meetings_for_page_query/0 returns past meetings in the correct order" do
      oldest = create_meeting_for_week(1)
      middle = create_meeting_for_week(2)
      newest = create_meeting_for_week(3)

      result = Meetings.meetings_for_page_query() |> Repo.all()

      assert length(result) == 3
      assert :lists.nth(1, result).id == newest.id
      assert :lists.nth(2, result).id == middle.id
      assert :lists.nth(3, result).id == oldest.id
    end

    test "it returns past meetings correctly paginated" do
      create_eleven_past_meetings()
      page = 1
      per_page = 5
      result = Pagination.paginate(Meetings.meetings_for_page_query(), page, per_page)
  
      assert result.count == 11
      assert result.has_next == true
      assert result.has_prev == false
      assert result.last == 3
      assert result.page == 1
      assert result.prev_page == nil
      assert length(result.results) = 5 
    end
  end
end