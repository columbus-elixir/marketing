defmodule CbusElixirWeb.VideoController do
  use CbusElixirWeb, :controller

  plug(
    BasicAuth,
    [use_config: {:cbus_elixir, :cbus_auth_config}] when action in [:new, :edit, :delete]
  )

  def index(conn, _params) do
    render(conn, "index.html")
  end
end