defmodule CbusElixirWeb.PageView do
  use CbusElixirWeb, :view

  def gravatar_url(email) do
    hash =
      email
      |> String.trim
      |> String.downcase
      |> md5_hash
      |> Base.encode16()
      |> String.downcase

    "https://www.gravatar.com/avatar/#{hash}"
  end

  defp md5_hash(email) do
    :crypto.hash(:md5, email)
  end
end
