defmodule CbusElixirWeb.MeetingRegistrationControllerTest do
  use CbusElixirWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, meeting_registration_path(conn, :index))
    assert html_response(conn, 200) =~ "Registration for"
  end

  test "shows correct next_meeting.date given a specific date", %{conn: conn} do
    date = "2018-03-25"
    conn = get(conn, "/?date=#{date}")
    assert html_response(conn, 200) =~ "2018-04-03"
  end

  test "shows correct meeting on day of current meeting", %{conn: conn} do
    date = "2018-04-03"
    conn = get(conn, "/?date=#{date}")
    assert html_response(conn, 200) =~ "2018-04-03"
  end
end
