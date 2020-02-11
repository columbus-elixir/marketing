defmodule CbusElixirWeb.MeetingController do
  use CbusElixirWeb, :controller

  alias CbusElixir.App
  alias CbusElixir.App.Meeting
  alias CbusElixir.App.Meetings
  alias CbusElixir.Repo
  alias CbusElixir.Pagination

  def index(conn, params) do
    page = params["page"] || 1
    per_page = params["per_page"] || 5
    paged_result = Pagination.paginate(Meetings.meetings_for_page_query(), page, per_page)

    preloaded_results =
      Map.get(paged_result, :results)
      |> Repo.preload(:speakers)

    paged_result_w_preload =
      paged_result
      |> Map.put(:results, preloaded_results)

    render(conn, "index.html", paged_result: paged_result_w_preload)
  end

  def show(conn, %{"id" => id}) do
    attendees = Meetings.attendees_for_meeting(id)

    render(conn, "show.html", attendees: attendees)
  end

  def new(conn, _params) do
    changeset = App.change_meeting(%Meeting{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"meeting" => meeting_params}) do
    case App.create_meeting(meeting_params) do
      {:ok, meeting} ->
        conn
        |> put_flash(:info, "Meeting created successfully.")
        |> redirect(to: meeting_path(conn, :show, meeting))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
