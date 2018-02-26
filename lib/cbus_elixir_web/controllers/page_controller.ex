defmodule CbusElixirWeb.PageController do
  use CbusElixirWeb, :controller

  alias CbusElixir.Repo
  alias CbusElixir.App.Speaker

  def index(conn, _params) do
    speakers = Repo.all(Speaker)
    name = get_session(conn, :current_username)
    render(conn, "index.html", current_username: name, speakers: speakers)
  end

end
