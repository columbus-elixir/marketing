defmodule CbusElixirWeb.AttendeeControllerTest do
  use CbusElixirWeb.ConnCase

  @create_attrs %{
    email: "some@email",
    name: "some name",
    new_to_cbus_elixir: true,
    new_to_elixir: true,
    twitter: "@handle",
    meeting_id: 1
  }
  @create_attrs2 %{
    email: "some@email",
    name: "some name",
    new_to_cbus_elixir: true,
    new_to_elixir: true,
    meeting_id: 1
  }

  @invalid_attrs %{
    email: nil,
    name: nil,
    new_to_cbus_elixir: nil,
    new_to_elixir: nil,
    twitter: "@handle",
    meeting_id: nil
  }
  @invalid_twitter_attrs1 %{
    email: "some@email",
    name: "some name",
    new_to_cbus_elixir: true,
    new_to_elixir: true,
    twitter: "@@h$a%ndle",
    meeting_id: 1
  }
  @invalid_twitter_attrs2 %{
    email: "some@email",
    name: "some name",
    new_to_cbus_elixir: true,
    new_to_elixir: true,
    twitter: "thishastoomanycharacters",
    meeting_id: 1
  }

  describe "new attendee" do
    test "renders form", %{conn: conn} do
      conn = get(conn, attendee_path(conn, :new))
      assert html_response(conn, 200) =~ "New Attendee"
    end
  end

  describe "create attendee" do
    test "redirects to meeting registration when data is valid", %{conn: conn} do
      conn = post(conn, attendee_path(conn, :create), attendee: @create_attrs)

      assert redirected_to(conn) == meeting_registration_path(conn, :index)

      conn = get(conn, meeting_registration_path(conn, :index))
      assert html_response(conn, 200) =~ "Attendee created successfully."
    end

    test "Shows new attendee data on meeting /registation when data is valid", %{conn: conn} do
      conn = post(conn, attendee_path(conn, :create), attendee: @create_attrs)

      assert redirected_to(conn) == meeting_registration_path(conn, :index)

      conn = get(conn, meeting_registration_path(conn, :index))
      assert html_response(conn, 200) =~ "some@email"
    end

    test "redirects to meeting registration when no twitter handle", %{conn: conn} do
      conn = post(conn, attendee_path(conn, :create), attendee: @create_attrs2)

      assert redirected_to(conn) == meeting_registration_path(conn, :index)

      conn = get(conn, meeting_registration_path(conn, :index))
      assert html_response(conn, 200) =~ "Attendee created successfully."
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, attendee_path(conn, :create), attendee: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Attendee"
    end

    test "renders errors when twitter handle has invalid characters", %{conn: conn} do
      conn = post(conn, attendee_path(conn, :create), attendee: @invalid_twitter_attrs1)
      assert html_response(conn, 200) =~ "Characters $% not allowed in Twitter handle"
    end

    test "renders errors when twitter handle has too many characters", %{conn: conn} do
      conn = post(conn, attendee_path(conn, :create), attendee: @invalid_twitter_attrs2)
      assert html_response(conn, 200) =~ "should be at most 15 character(s)"
    end
  end
end
