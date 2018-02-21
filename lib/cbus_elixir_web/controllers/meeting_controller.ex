defmodule CbusElixirWeb.MeetingController do
  use CbusElixirWeb, :controller

  alias CbusElixir.App
  alias CbusElixir.App.Meeting

  action_fallback CbusElixirWeb.FallbackController

  def index(conn, _params) do
    meetings = App.list_meetings()
    render(conn, "index.json", meetings: meetings)
  end

  def create(conn, %{"meeting" => meeting_params}) do
    with {:ok, %Meeting{} = meeting} <- App.create_meeting(meeting_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", meeting_path(conn, :show, meeting))
      |> render("show.json", meeting: meeting)
    end
  end

  def show(conn, %{"id" => id}) do
    meeting = App.get_meeting!(id)
    render(conn, "show.json", meeting: meeting)
  end

  def update(conn, %{"id" => id, "meeting" => meeting_params}) do
    meeting = App.get_meeting!(id)

    with {:ok, %Meeting{} = meeting} <- App.update_meeting(meeting, meeting_params) do
      render(conn, "show.json", meeting: meeting)
    end
  end

  def delete(conn, %{"id" => id}) do
    meeting = App.get_meeting!(id)
    with {:ok, %Meeting{}} <- App.delete_meeting(meeting) do
      send_resp(conn, :no_content, "")
    end
  end
end
