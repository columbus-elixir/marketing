defmodule CbusElixirWeb.MeetingController do
  use CbusElixirWeb, :controller

  alias CbusElixir.App
  alias CbusElixir.App.Meeting
  alias CbusElixir.App.Meetings
  alias CbusElixir.Repo
  alias CbusElixir.Pagination

  plug(
    BasicAuth,
    [use_config: {:cbus_elixir, :cbus_auth_config}] when action in [:new, :edit, :delete]
  )

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
    meeting = App.get_meeting!(id)

    render(conn, "show.html", attendees: attendees, meeting: meeting)
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

  def edit(conn, %{"id" => id}) do
    meeting = App.get_meeting!(id)
    changeset = App.change_meeting(meeting)
    render(conn, "edit.html", meeting: meeting, changeset: changeset)
  end

  def update(conn, %{"id" => id, "meeting" => meeting_params}) do
    meeting = App.get_meeting!(id)

    case App.update_meeting(meeting, meeting_params) do
      {:ok, meeting} ->
        conn
        |> put_flash(:info, "Meeting updated successfully.")
        |> redirect(to: meeting_path(conn, :show, meeting))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", meeting: meeting, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    meeting = App.get_meeting!(id)
    {:ok, _meeting} = App.delete_meeting(meeting)

    conn
    |> put_flash(:info, "Meeting deleted successfully.")
    |> redirect(to: meeting_path(conn, :index))
  end
end
