defmodule CbusElixirWeb.Email do
  import Bamboo.Email
  use Bamboo.Phoenix, view: CbusElixirWeb.EmailView

  def welcome_email(email) do
    new_email()
    |>to(email)
    |>from("memjay3279@gmail.com")
    |>subject("Welcome to Columbus Elixir!")
    |>html_body("Welcome to group!")
  end
end
