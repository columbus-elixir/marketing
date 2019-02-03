defmodule CbusElixir.PaginationTest do
  use CbusElixir.DataCase

  alias CbusElixir.Repo
  alias CbusElixir.App.Meeting
  alias CbusElixir.App.Meetings
  alias CbusElixir.Pagination

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

  describe "paginate/3" do
    test "it returns past meetings correctly paginated" do
      create_eleven_past_meetings()
      page = 1
      per_page = 5
      result = Pagination.paginate(Meetings.meetings_for_page_query(), page, per_page)
      page_two = Pagination.paginate(Meetings.meetings_for_page_query(), 2, per_page)
      page_three = Pagination.paginate(Meetings.meetings_for_page_query(), 3, per_page)

      assert result.count == 11
      assert result.has_next == true
      assert result.has_prev == false
      assert result.last == 3
      assert result.page == 1
      assert result.prev_page == nil
      assert length(result.results) == 5

      assert page_two.count == 11
      assert page_two.has_next == true
      assert page_two.has_prev == true
      assert page_two.last == 3
      assert page_two.page == 2
      assert page_two.prev_page == 1
      assert length(page_two.results) == 5

      assert page_three.count == 11
      assert page_three.has_next == false
      assert page_three.has_prev == true
      assert page_three.last == 3
      assert page_three.page == 3
      assert page_three.prev_page == 2
      assert length(page_three.results) == 1
    end
  end
end