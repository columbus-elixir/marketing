defmodule CbusElixirWeb.UserController do
  use CbusElixirWeb, :controller

  import CbusElixirWeb.Authorize
  alias Phauxth.Log
  alias CbusElixir.Accounts
  alias CbusElixirWeb.Email
  alias CbusElixirWeb.Mailer
  alias Phauxth.Login
  alias CbusElixir.App

  # the following plugs are defined in the controllers/authorize.ex file
  plug :user_check when action in [:index, :show, :admin]
  plug :id_check when action in [:edit, :update, :delete]
  plug :is_admin? when action in [:index, :admin, :admin_toggle]

  def index(conn, _) do
    users = Accounts.list_users
    render(conn, "index.html", users: users)
  end

  def new(conn, _) do
    changeset = Accounts.change_user(%Accounts.User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.create_user(user_params) do
      {:ok, user} ->
        Log.info(%Log{user: user.id, message: "user created"})
        session_id = Login.gen_session_id("F")
        Accounts.add_session(user, session_id, System.system_time(:second))
        Email.welcome_email(user.email)
        |> Mailer.deliver_later()
        Login.add_session(conn, session_id, user.id)
        |> login_success(page_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(%Plug.Conn{assigns: %{current_user: user}} = conn, %{"id" => id}) do
    user = (id == to_string(user.id) and user) || Accounts.get(id)
    your_speaking_requests = App.this_users_speaking_requests(user)
    render(conn, "show.html", user: user, your_speaking_requests: your_speaking_requests)
  end

  def edit(%Plug.Conn{assigns: %{current_user: user}} = conn, %{"id" => id}) do
    user = (id == to_string(user.id) and user) || Accounts.get(id)
    changeset = Accounts.change_user(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(%Plug.Conn{assigns: %{current_user: user}} = conn, %{"user" => user_params}) do
    case Accounts.update_user(user, user_params) do
      {:ok, user} ->
        success(conn, "Your profile has been updated successfully", user_path(conn, :show, user))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(%Plug.Conn{assigns: %{current_user: user}} = conn, %{"id" => id}) do
    user = (id == to_string(user.id) and user) || Accounts.get(id)

    {:ok, _user} = Accounts.delete_user(user)

    delete_session(conn, :phauxth_session_id)
    |> success("Your profile has been deleted successfully. Sorry to see you go!", session_path(conn, :new))
  end

  def admin(conn, params) do
    page = Accounts.list_users_paged(params)
    speakers = App.list_speakers_by_status("Open")
    approvals = App.list_speakers_by_status("Approved")
    render(conn, "admin.html", speakers: speakers, approvals: approvals, users: page.entries, page: page)
  end

  def admin_toggle(%Plug.Conn{assigns: %{current_user: current_user}} = conn, %{"user_id" => id}) do
    user = Accounts.get(id)
    case Accounts.update_user(user, %{is_admin: !user.is_admin}) do
      {:ok, user} ->
        success(conn, "Admin Flag has been updated successfully", user_admin_path(conn, :admin, current_user.id))
      {:error, %Ecto.Changeset{} = changeset} ->
        success(conn, "Admin Flag has not been updated successfully", user_admin_path(conn, :admin, current_user.id))
    end
  end
end
