defmodule CbusElixirWeb.DateParser do
  
  def parse_meeting_date(nil, default), do: default

  def parse_meeting_date(date, default) do
    date
    |> Date.from_iso8601() 
    |> case do
      {:ok, result} -> result
      {:error, _ } -> default
    end
  end
end