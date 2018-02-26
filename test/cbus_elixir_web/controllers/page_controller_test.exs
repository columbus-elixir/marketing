defmodule CbusElixirWeb.PageControllerTest do
  use CbusElixirWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "What is Columbus Elixir"
  end
end
