defmodule CbusElixir.Plugs.SetCurrentUserName do
  import Plug.Conn
  require IEx

  def init(default), do: default

  def call(%Plug.Conn{params: %{}} = conn, _default) do
    name = get_session(conn, :current_username)
    assign(conn, :current_username, name)
  end
end