defmodule CbusElixirWeb.FormattingHelpers do
  def formatted_date(date) do
    date |> Timex.to_date() |> Date.to_string()
  end
end
