defmodule CbusElixirWeb.FormattingHelpers do
  def formatted_date(date) do
    Timex.to_date(date) |> Date.to_string
  end
end
