defmodule CbusElixirWeb.AttendeeControllerTest do
  use CbusElixirWeb.ConnCase

  alias CbusElixir.App

  @create_attrs %{email: "some email", name: "some name", new_to_cbus_elixir: true, new_to_elixir: true, twitter: "some twitter"}
  @update_attrs %{email: "some updated email", name: "some updated name", new_to_cbus_elixir: false, new_to_elixir: false, twitter: "some updated twitter"}
  @invalid_attrs %{email: nil, name: nil, new_to_cbus_elixir: nil, new_to_elixir: nil, twitter: nil}

  def fixture(:attendee) do
    {:ok, attendee} = App.create_attendee(@create_attrs)
    attendee
  end

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

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == attendee_path(conn, :show, id)

      conn = get conn, attendee_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Attendee"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, attendee_path(conn, :create), attendee: @invalid_attrs
      assert html_response(conn, 200) =~ "New Attendee"
    end
  end

  describe "edit attendee" do
    setup [:create_attendee]

    test "renders form for editing chosen attendee", %{conn: conn, attendee: attendee} do
      conn = get conn, attendee_path(conn, :edit, attendee)
      assert html_response(conn, 200) =~ "Edit Attendee"
    end
  end

  describe "update attendee" do
    setup [:create_attendee]

    test "redirects when data is valid", %{conn: conn, attendee: attendee} do
      conn = put conn, attendee_path(conn, :update, attendee), attendee: @update_attrs
      assert redirected_to(conn) == attendee_path(conn, :show, attendee)

      conn = get conn, attendee_path(conn, :show, attendee)
      assert html_response(conn, 200) =~ "some updated email"
    end

    test "renders errors when data is invalid", %{conn: conn, attendee: attendee} do
      conn = put conn, attendee_path(conn, :update, attendee), attendee: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Attendee"
    end
  end

  describe "delete attendee" do
    setup [:create_attendee]

    test "deletes chosen attendee", %{conn: conn, attendee: attendee} do
      conn = delete conn, attendee_path(conn, :delete, attendee)
      assert redirected_to(conn) == attendee_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, attendee_path(conn, :show, attendee)
      end
    end
  end

  defp create_attendee(_) do
    attendee = fixture(:attendee)
    {:ok, attendee: attendee}
  end
end
