defmodule CbusElixirWeb.SpeakerView do
  use CbusElixirWeb, :view
  alias CbusElixirWeb.SpeakerView

  def render("index.json", %{speakers: speakers}) do
    %{data: render_many(speakers, SpeakerView, "speaker.json")}
  end

  def render("show.json", %{speaker: speaker}) do
    %{data: render_one(speaker, SpeakerView, "speaker.json")}
  end

  def render("speaker.json", %{speaker: speaker}) do
    %{id: speaker.id,
      name: speaker.name,
      url: speaker.url,
      title: speaker.title}
  end
end
