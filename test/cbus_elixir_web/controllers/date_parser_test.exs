defmodule CbusElixirWeb.DateParserTest do
  use CbusElixir.DataCase

  alias CbusElixirWeb.DateParser

  test "Nil Date Query String" do
    date = nil
    result = DateParser.parse_meeting_date(date, ~D[2018-03-06])
    assert result == ~D[2018-03-06]
  end

  test "Invalid Date Query String" do
    date = "20180325"
    result = DateParser.parse_meeting_date(date, ~D[2018-03-06])
    assert result == ~D[2018-03-06]
  end

  test "Valid Date Query String" do
    date = "2018-03-25"
    result = DateParser.parse_meeting_date(date, ~D[2018-03-06])
    assert result == ~D[2018-03-25]
  end
end
