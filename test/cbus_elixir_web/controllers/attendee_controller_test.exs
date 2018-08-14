defmodule CbusElixirWeb.AttendeeControllerTest do
  use CbusElixirWeb.ConnCase

  @create_attrs %{email: "some email", name: "some name", new_to_cbus_elixir: true, new_to_elixir: true, meeting_id: 1}
  @invalid_attrs %{email: nil, name: nil, new_to_cbus_elixir: nil, new_to_elixir: nil, meeting_id: nil}

  describe "index" do
    test "lists all attendees", %{conn: conn} do
      conn = get conn, attendee_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Attendees"
    end
  end

  describe "new attendee" do
    test "renders form", %{conn: conn} do
      conn = get conn, attendee_path(conn, :new)
      assert html_response(conn, 200) =~ "New Attendee"
    end
  end

  describe "create attendee" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, attendee_path(conn, :create), attendee: @create_attrs

      assert redirected_to(conn) == meeting_registration_path(conn, :index)

      conn = get conn, meeting_registration_path(conn, :index)
      assert html_response(conn, 200) =~ "Next Meeting"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, attendee_path(conn, :create), attendee: @invalid_attrs
      assert html_response(conn, 200) =~ "New Attendee"
    end
  end

end
