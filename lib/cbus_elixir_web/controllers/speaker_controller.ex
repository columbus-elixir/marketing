defmodule CbusElixirWeb.SpeakerController do

  use CbusElixirWeb, :controller
  alias CbusElixir.App
  alias CbusElixir.App.Speaker
  alias CbusElixir.App.Meetings
  alias CbusElixir.Accounts
  alias CbusElixir.Meeting
  import CbusElixirWeb.Authorize
  alias CbusElixirWeb.Email
  alias CbusElixirWeb.Mailer

  plug :is_admin? when action in [:approve_speaker]
  plug :user_check when action in [:new]


  def index(conn, _params) do
    speakers = App.list_speakers()
    render(conn, "index.html", speakers: speakers)
  end

  def new(conn, _params) do
    changeset = App.change_speaker(%Speaker{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user_id" => user_id, "speaker" => speaker_params}) do
    case App.create_speaker(Map.put(speaker_params, "user_id", user_id)) do
      {:ok, speaker} ->
        email = Accounts.get(speaker.user_id).email
        title = speaker.title
        conn
        |> put_flash(:info, "Thank you! Your speaking request has been processed!")
        |> redirect(to: page_path(conn, :index))
        Email.speaker_request_submitted(email, title)
        |> Mailer.deliver_later
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    speaker = App.get_speaker!(id)
    render(conn, "show.html", speaker: speaker)
  end

  def edit(conn, %{"id" => id}) do
    speaker = App.get_speaker!(id)
    changeset = App.change_speaker(speaker)
    render(conn, "edit.html", speaker: speaker, changeset: changeset)
  end

  def update(conn, %{"id" => id, "speaker" => speaker_params}) do
    speaker = App.get_speaker!(id)

    case App.update_speaker(speaker, speaker_params) do
      {:ok, speaker} ->
        conn
        |> put_flash(:info, "Speaker updated successfully.")
        #|> redirect(to: speaker_path(conn, :show, speaker))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", speaker: speaker, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    speaker = App.get_speaker!(id)
    {:ok, _speaker} = App.delete_speaker(speaker)

    conn
    |> put_flash(:info, "Speaker deleted successfully.")
    |> redirect(to: page_path(conn, :index))
  end

  def approve_speaker(conn, %{"speaker_id" => speaker_id, "user_id" => user_id }) do
    speaker = App.get_speaker!(speaker_id)
    user = Accounts.get(user_id)
    App.update_speaker(speaker, %{status: "Approved"})
    Email.speaker_request_submitted(user.email, speaker.title)
    |> Mailer.deliver_later
    conn
    |> put_flash(:info, "Speaking Request for #{user.first_name} #{user.last_name} has been approved!")
    |> redirect(to: page_path(conn, :index))
  end

  def cancel_speaker(conn, %{"speaker_id" => speaker_id, "user_id" => user_id }) do
    speaker = App.get_speaker!(speaker_id)
    App.update_speaker(speaker, %{status: "Cancelled"})
    conn
    |> put_flash(:info, "Your talk, #{speaker.title}, has been cancelled!")
    |> redirect(to: page_path(conn, :index))
  end

end
