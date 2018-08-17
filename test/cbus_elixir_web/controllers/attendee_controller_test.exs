defmodule CbusElixirWeb.AttendeeControllerTest do
  use CbusElixirWeb.ConnCase

  @create_attrs %{email: "some@email", name: "some name", new_to_cbus_elixir: true, new_to_elixir: true, twitter: "@handle", meeting_id: 1}
  @invalid_attrs %{email: nil, name: nil, new_to_cbus_elixir: nil, new_to_elixir: nil, twitter: "@handle", meeting_id: nil}
  @invalid_twitter_attrs %{email: "some@email", name: "some name", new_to_cbus_elixir: true, new_to_elixir: true, twitter: "@@h$a%ndle", meeting_id: 1}

  describe "new attendee" do
    test "renders form", %{conn: conn} do
      conn = get conn, attendee_path(conn, :new)
      assert html_response(conn, 200) =~ "New Attendee"
    end
  end

  describe "create attendee" do
    test "redirects to meeting registration when data is valid", %{conn: conn} do
      conn = post conn, attendee_path(conn, :create), attendee: @create_attrs

      assert redirected_to(conn) == meeting_registration_path(conn, :index)

      conn = get conn, meeting_registration_path(conn, :index)
      assert html_response(conn, 200) =~ "Register for this meetup"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, attendee_path(conn, :create), attendee: @invalid_attrs
      assert html_response(conn, 200) =~ "New Attendee"
    end

    test "renders errors when twitter handle is invalid", %{conn: conn} do
      conn = post conn, attendee_path(conn, :create), attendee: @invalid_twitter_attrs
      assert html_response(conn, 200) =~ "Characters $% not allowed in Twitter handle"
    end
  end

end
