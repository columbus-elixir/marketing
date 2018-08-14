defmodule CbusElixirWeb.AttendeeController do
  use CbusElixirWeb, :controller

  alias CbusElixir.App
  alias CbusElixir.App.{ Attendee, Meetings }

  def index(conn, _params) do
    attendees = App.list_attendees()
    render(conn, "index.html", attendees: attendees)
  end

  def new(conn, _params) do
    changeset = App.change_attendee(%Attendee{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"attendee" => attendee_params}) do
    meeting_id = Meetings.next_meeting(Timex.now).id
    attendee_params = attendee_params 
      |> Map.put("meeting_id", meeting_id)
    case App.create_attendee(attendee_params) do
      {:ok, attendee} ->
        conn
        |> put_flash(:info, "Attendee created successfully.")
        |> redirect(to: meeting_registration_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    attendee = App.get_attendee!(id)
    render(conn, "show.html", attendee: attendee)
  end

  def edit(conn, %{"id" => id}) do
    attendee = App.get_attendee!(id)
    changeset = App.change_attendee(attendee)
    render(conn, "edit.html", attendee: attendee, changeset: changeset)
  end

  def update(conn, %{"id" => id, "attendee" => attendee_params}) do
    attendee = App.get_attendee!(id)

    case App.update_attendee(attendee, attendee_params) do
      {:ok, attendee} ->
        conn
        |> put_flash(:info, "Attendee updated successfully.")
        |> redirect(to: attendee_path(conn, :show, attendee))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", attendee: attendee, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    attendee = App.get_attendee!(id)
    {:ok, _attendee} = App.delete_attendee(attendee)

    conn
    |> put_flash(:info, "Attendee deleted successfully.")
    |> redirect(to: attendee_path(conn, :index))
  end
end
