defmodule CbusElixir.Plugs.SetNextMeeting do
  import Plug.Conn

  alias CbusElixir.App.Meetings

  def init(_params) do
  end

  def call(conn, _params) do
    if conn.assigns[:next_meeting] do
      conn
    else
      next_meeting = Meetings.next_meeting(Timex.now())
      assign(conn, :next_meeting, next_meeting)
    end
  end
end
