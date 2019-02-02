defmodule CbusElixirWeb.PageControllerTest do
  use CbusElixirWeb.ConnCase

  alias CbusElixir.App.Meeting
  alias CbusElixir.Repo

  test "GET /", %{conn: conn} do
    meeting_date = Timex.shift(NaiveDateTime.utc_now(), days: 1)

    %Meeting{}
    |> Meeting.changeset(%{date: meeting_date})
    |> Repo.insert!()

    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "What is Columbus Elixir"
  end

  test "Date Query String", %{conn: conn} do
    %Meeting{}
    |> Meeting.changeset(%{date: ~N[2018-04-03T00:00:00]})
    |> Repo.insert!()

    date = "2018-03-25"
    conn = get(conn, "/?date=#{date}")
    assert html_response(conn, 200) =~ "2018-04-03"
  end
end
