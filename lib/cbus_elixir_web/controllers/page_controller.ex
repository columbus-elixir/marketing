defmodule CbusElixirWeb.PageController do
  use CbusElixirWeb, :controller

  alias CbusElixir.Repo
  alias CbusElixir.App.Speaker

  def index(conn, _params) do
    speakers = Repo.all(Speaker)
    render conn, "index.html", speakers: speakers
  end
end
