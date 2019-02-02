defmodule CbusElixirWeb.SpeakerControllerTest do
  use CbusElixirWeb.ConnCase

  alias CbusElixir.App
  alias CbusElixir.App.Meeting
  alias CbusElixir.Repo

  @create_attrs %{
    email: "some email",
    name: "some name",
    title: "some title",
    url: "some url"
  }
  @update_attrs %{
    email: "some updated email",
    name: "some updated name",
    title: "some updated title",
    url: "some updated url"
  }
  @invalid_attrs %{email: nil, meeting_id: nil, name: nil, title: nil, url: nil}

  @username Application.get_env(:cbus_elixir, :cbus_auth_config)[:username]
  @password Application.get_env(:cbus_elixir, :cbus_auth_config)[:password]

  setup do
    conn =
      build_conn()
      |> using_basic_auth(@username, @password)

    %{conn: conn}
  end

  def meeting_id() do
    %Meeting{}
    |> Meeting.changeset(%{date: NaiveDateTime.utc_now()})
    |> Repo.insert!()
    |> Map.get(:id)
  end

  def fixture(:speaker) do
    {:ok, speaker} =
      %{meeting_id: meeting_id()}
      |> Enum.into(@create_attrs)
      |> App.create_speaker()

    speaker
  end

  describe "index" do
    test "lists all speakers", %{conn: conn} do
      conn = get(conn, speaker_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Speakers"
    end
  end

  describe "new speaker" do
    test "renders form", %{conn: conn} do
      conn = get(conn, speaker_path(conn, :new))
      assert html_response(conn, 200) =~ "New Speaker"
    end
  end

  describe "create speaker" do
    test "redirects to show when data is valid", %{conn: conn} do
      attrs =
        %{meeting_id: meeting_id()}
        |> Enum.into(@create_attrs)

      conn = post(conn, speaker_path(conn, :create), speaker: attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == speaker_path(conn, :show, id)

      conn =
        conn
        |> recycle_conn_auth()
        |> get(speaker_path(conn, :show, id))

      assert html_response(conn, 200) =~ "Show Speaker"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, speaker_path(conn, :create), speaker: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Speaker"
    end
  end

  describe "edit speaker" do
    setup [:create_speaker]

    test "renders form for editing chosen speaker", %{conn: conn, speaker: speaker} do
      conn = get(conn, speaker_path(conn, :edit, speaker))
      assert html_response(conn, 200) =~ "Edit Speaker"
    end
  end

  describe "update speaker" do
    setup [:create_speaker]

    test "redirects when data is valid", %{conn: conn, speaker: speaker} do
      conn = put(conn, speaker_path(conn, :update, speaker), speaker: @update_attrs)
      assert redirected_to(conn) == speaker_path(conn, :show, speaker)

      conn =
        conn
        |> recycle_conn_auth()
        |> get(speaker_path(conn, :show, speaker))

      assert html_response(conn, 200) =~ "some updated email"
    end

    test "renders errors when data is invalid", %{conn: conn, speaker: speaker} do
      conn = put(conn, speaker_path(conn, :update, speaker), speaker: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Speaker"
    end
  end

  describe "delete speaker" do
    setup [:create_speaker]

    test "deletes chosen speaker", %{conn: conn, speaker: speaker} do
      conn = delete(conn, speaker_path(conn, :delete, speaker))
      assert redirected_to(conn) == speaker_path(conn, :index)

      conn =
        conn
        |> recycle_conn_auth()

      assert_error_sent(404, fn ->
        get(conn, speaker_path(conn, :show, speaker))
      end)
    end
  end

  defp create_speaker(_) do
    speaker = fixture(:speaker)
    {:ok, speaker: speaker}
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
