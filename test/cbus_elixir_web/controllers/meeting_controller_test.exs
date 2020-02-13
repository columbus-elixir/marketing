defmodule CbusElixirWeb.MeetingControllerTest do
  use CbusElixirWeb.ConnCase

  alias CbusElixir.App
  alias CbusElixir.App.Meeting
  alias CbusElixir.Repo

  @create_attrs %{
    date: %{
      day: "1",
      month: "1",
      year: "2000"
    },
    rsvp_link: "https://example.com"
  }
  @update_attrs %{
    date: %{
      day: "2",
      month: "1",
      year: "2000"
    },
    rsvp_link: "https://columbuselixir.com"
  }
  @invalid_attrs %{date: %{day: "-1", month: "-1", year: "-2000"}}

  @username Application.get_env(:cbus_elixir, :cbus_auth_config)[:username]
  @password Application.get_env(:cbus_elixir, :cbus_auth_config)[:password]

  setup do
    conn =
      build_conn()
      |> using_basic_auth(@username, @password)

    %{conn: conn}
  end

  def fixture(:meeting) do
    {:ok, meeting} = App.create_meeting(@create_attrs)

    meeting
  end

  describe "index" do
    test "lists past meetings", %{conn: conn} do
      conn = get(conn, meeting_path(conn, :index))
      assert html_response(conn, 200) =~ "<th>Meeting</th>"
    end
  end

  describe "new meeting" do
    test "renders form", %{conn: conn} do
      conn = get(conn, meeting_path(conn, :new))
      assert html_response(conn, 200) =~ "New Meeting"
    end
  end

  describe "create meeting" do
    test "redirects to show when data is valid", %{conn: conn} do
      attrs = @create_attrs

      conn = post(conn, meeting_path(conn, :create), meeting: attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == meeting_path(conn, :show, id)

      conn =
        conn
        |> recycle_conn_auth()
        |> get(meeting_path(conn, :show, id))

      assert html_response(conn, 200) =~ "Show Meeting"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, meeting_path(conn, :create), meeting: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Meeting"
    end
  end

  describe "edit meeting" do
    setup [:create_meeting]

    test "renders form for editing chosen meeting", %{conn: conn, meeting: meeting} do
      conn = get(conn, meeting_path(conn, :edit, meeting))
      assert html_response(conn, 200) =~ "Edit Meeting"
    end
  end

  describe "update meeting" do
    setup [:create_meeting]

    test "redirects when data is valid", %{conn: conn, meeting: meeting} do
      conn = put(conn, meeting_path(conn, :update, meeting), meeting: @update_attrs)
      assert redirected_to(conn) == meeting_path(conn, :show, meeting)

      conn =
        conn
        |> recycle_conn_auth()
        |> get(meeting_path(conn, :show, meeting))

      assert html_response(conn, 200) =~ "Show Meeting"
    end

    test "renders errors when data is invalid", %{conn: conn, meeting: meeting} do
      conn = put(conn, meeting_path(conn, :update, meeting), meeting: @invalid_attrs)
      assert html_response(conn, 200) =~ "is invalid"
    end
  end

  describe "delete meeting" do
    setup [:create_meeting]

    test "deletes chosen meeting", %{conn: conn, meeting: meeting} do
      conn = delete(conn, meeting_path(conn, :delete, meeting))
      assert redirected_to(conn) == meeting_path(conn, :index)

      conn =
        conn
        |> recycle_conn_auth()

      assert_error_sent(404, fn ->
        get(conn, meeting_path(conn, :show, meeting))
      end)
    end
  end

  defp create_meeting(_) do
    meeting = fixture(:meeting)
    {:ok, meeting: meeting}
  end

  defp recycle_conn_auth(conn) do
    conn
    |> recycle()
    |> using_basic_auth(@username, @password)
  end

  defp using_basic_auth(conn, username, password) do
    header_content = "Basic " <> Base.encode64("#{username}:#{password}")
    conn |> put_req_header("authorization", header_content)
  end
end
