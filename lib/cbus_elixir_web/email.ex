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

  def speaker_request_submitted(email, title, date) do
    new_email()
    |>to(email)
    |>from("memjay3279@gmail.com")
    |>subject("Your talk #{title} has been submitted.")
    |>html_body("Your talk #{title} for the #{date} meeting has been submitted and is pending approval from our admins.")
  end

  def speaking_request_approved(email, title, date, approver_first, approver_last) do
    new_email()
    |>to(email)
    |>from("memjay3279@gmail.com")
    |>subject("You speaking request has been approved!.")
    |>html_body("Your talk #{title} for the #{date} meeting has been approved by #{approver_first} #{approver_last}.")
  end

  def speaking_request_cancelled(email, title, date, first, last) do
    new_email()
    |>to(email)
    |>from("memjay3279@gmail.com")
    |>subject("#{first} #{last} has cancelled #{title} for #{date}")
    |>html_body("This talk has been cancelled. Please see if another speaker could be available.S")
  end

  def youre_an_admin(email, admin_first, admin_last) do
    new_email()
    |>to(email)
    |>from("memjay3279@gmail.com")
    |>subject("You're now an admin for Columbus Elixir")
    |>html_body("You are now an admin for Columbus Elixir. You were made an admin by #{admin_first} #{admin_last}")
  end

  def youre_no_longer_an_admin(email) do
    new_email()
    |>to(email)
    |>from("memjay3279@gmail.com")
    |>subject("You are no longer an admin for Columbus Elixir")
    |>html_body("You have been removed as an adminstrator for Colubmus Elixir")
  end
end
