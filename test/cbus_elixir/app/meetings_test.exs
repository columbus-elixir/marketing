defmodule CbusElixir.MeetingsTest do
  use CbusElixir.DataCase

  alias CbusElixir.Repo
  alias CbusElixir.App.Meeting
  alias CbusElixir.App.Meetings

  def create_meeting_for_week(week) when is_integer(week) do
    meeting_date = Timex.shift(~N[2018-01-01T00:00:00], days: week * 7)

    %Meeting{}
    |> Meeting.changeset(%{date: meeting_date})
    |> Repo.insert!()
  end

  describe "Paginated Meetings" do
    test "meetings_for_page_query/0 returns past meetings in the correct order" do
      oldest = create_meeting_for_week(1)
      middle = create_meeting_for_week(2)
      newest = create_meeting_for_week(3)

      result = Meetings.meetings_for_page_query() |> Repo.all()

      assert length(result) == 3
      assert :lists.nth(1, result).id == oldest.id
      assert :lists.nth(2, result).id == middle.id
      assert :lists.nth(3, result).id == newest.id
    end
  end
end