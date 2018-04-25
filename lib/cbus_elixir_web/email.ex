defmodule CbusElixirWeb.Email do
  import Bamboo.Email
  use Bamboo.Phoenix, view: CbusElixirWeb.EmailView

  def welcome_email(email) do
    new_email()
    |>to(email)
    |>from("memjay3279@gmail.com")
    |>subject("Welcome to Columbus Elixir!")
    |>html_body("Welcome to the Columbus Elixir group! You can now receive updates and sign up to give talks!")
  end

  def speaker_request_submitted(email, title) do
    new_email()
    |>to(email)
    |>from("memjay3279@gmail.com")
    |>subject("Your talk #{title} has been submitted.")
    |>html_body("Your talk #{title} for the meeting has been submitted and is pending approval from our admins.")
  end

  def speaking_request_approved(email, title) do
    new_email()
    |>to(email)
    |>from("memjay3279@gmail.com")
    |>subject("You speaking request has been approved!.")
    |>html_body("Your talk #{title} has been approved.")
  end

  def speaking_request_cancelled(email, title, first, last) do
    new_email()
    |>to(email)
    |>from("memjay3279@gmail.com")
    |>subject("#{first} #{last} has cancelled #{title}")
    |>html_body("This talk has been cancelled. Please see if another speaker could be available.")
  end
end
