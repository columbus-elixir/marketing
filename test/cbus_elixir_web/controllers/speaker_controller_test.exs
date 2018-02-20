defmodule CbusElixirWeb.SpeakerControllerTest do
  use CbusElixirWeb.ConnCase

  alias CbusElixir.App
  alias CbusElixir.App.Speaker

  @create_attrs %{name: "some name", title: "some title", url: "some url"}
  @update_attrs %{name: "some updated name", title: "some updated title", url: "some updated url"}
  @invalid_attrs %{name: nil, title: nil, url: nil}

  def fixture(:speaker) do
    {:ok, speaker} = App.create_speaker(@create_attrs)
    speaker
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all speakers", %{conn: conn} do
      conn = get conn, speaker_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create speaker" do
    test "renders speaker when data is valid", %{conn: conn} do
      conn = post conn, speaker_path(conn, :create), speaker: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, speaker_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "name" => "some name",
        "title" => "some title",
        "url" => "some url"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, speaker_path(conn, :create), speaker: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update speaker" do
    setup [:create_speaker]

    test "renders speaker when data is valid", %{conn: conn, speaker: %Speaker{id: id} = speaker} do
      conn = put conn, speaker_path(conn, :update, speaker), speaker: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, speaker_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "name" => "some updated name",
        "title" => "some updated title",
        "url" => "some updated url"}
    end

    test "renders errors when data is invalid", %{conn: conn, speaker: speaker} do
      conn = put conn, speaker_path(conn, :update, speaker), speaker: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete speaker" do
    setup [:create_speaker]

    test "deletes chosen speaker", %{conn: conn, speaker: speaker} do
      conn = delete conn, speaker_path(conn, :delete, speaker)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, speaker_path(conn, :show, speaker)
      end
    end
  end

  defp create_speaker(_) do
    speaker = fixture(:speaker)
    {:ok, speaker: speaker}
  end
end
