defmodule CbusElixirWeb.AttendeeController do
  use CbusElixirWeb, :controller

  alias CbusElixir.App
  alias CbusElixir.App.{ Attendee, Meetings }

  def new(conn, _params) do
    changeset = App.change_attendee(%Attendee{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"attendee" => attendee_params}) do
    meeting_id = Meetings.next_meeting(Timex.now).id
    attendee_params = attendee_params 
      |> Map.put("meeting_id", meeting_id)
    case App.create_attendee(attendee_params) do
      {:ok, _attendee} ->
        conn
        |> put_flash(:info, "Attendee created successfully.")
        |> redirect(to: meeting_registration_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
