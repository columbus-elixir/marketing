defmodule CbusElixirWeb.SpeakerController do
  use CbusElixirWeb, :controller

  alias CbusElixir.App
  alias CbusElixir.App.Speaker

  action_fallback CbusElixirWeb.FallbackController

  def index(conn, _params) do
    speakers = App.list_speakers()
    render(conn, "index.json", speakers: speakers)
  end

  def create(conn, %{"speaker" => speaker_params}) do
    with {:ok, %Speaker{} = speaker} <- App.create_speaker(speaker_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", speaker_path(conn, :show, speaker))
      |> render("show.json", speaker: speaker)
    end
  end

  def show(conn, %{"id" => id}) do
    speaker = App.get_speaker!(id)
    render(conn, "show.json", speaker: speaker)
  end

  def update(conn, %{"id" => id, "speaker" => speaker_params}) do
    speaker = App.get_speaker!(id)

    with {:ok, %Speaker{} = speaker} <- App.update_speaker(speaker, speaker_params) do
      render(conn, "show.json", speaker: speaker)
    end
  end

  def delete(conn, %{"id" => id}) do
    speaker = App.get_speaker!(id)
    with {:ok, %Speaker{}} <- App.delete_speaker(speaker) do
      send_resp(conn, :no_content, "")
    end
  end
end
