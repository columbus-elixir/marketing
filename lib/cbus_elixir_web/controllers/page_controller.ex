defmodule CbusElixirWeb.PageController do
  use CbusElixirWeb, :controller

  alias CbusElixir.App

  def index(conn, _params) do
    speakers = App.list_speakers()
    render conn, "index.html", speakers: speakers
  end
end
