defmodule CbusElixirWeb.SpeakerController do
  
  use CbusElixirWeb, :controller

  alias CbusElixir.App
  alias CbusElixir.App.Speaker

  def index(conn, _params) do
    speakers = App.list_speakers()
    render(conn, "index.html", speakers: speakers)
  end

  def new(conn, _params) do
    changeset = App.change_speaker(%Speaker{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"speaker" => speaker_params}) do
    case App.create_speaker(speaker_params) do
      {:ok, speaker} ->
        conn
        |> put_flash(:info, "Speaker created successfully.")
        |> redirect(to: speaker_path(conn, :show, speaker))
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
        |> redirect(to: speaker_path(conn, :show, speaker))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", speaker: speaker, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    speaker = App.get_speaker!(id)
    {:ok, _speaker} = App.delete_speaker(speaker)

    conn
    |> put_flash(:info, "Speaker deleted successfully.")
    |> redirect(to: speaker_path(conn, :index))
  end

  # def get_meetings do
  #   today = Timex.today()
  #   meets = CbusElixir.Repo.all(from m in "meetings", 
  #     where: m.date > type(^today, Ecto.Date),
  #     limit: 5,
  #     select: {m.id, m.date})
  #   meetings = for {k, v} <- meets, do: {Timex.to_date(v) |> Date.to_string, k}
  # end
end
