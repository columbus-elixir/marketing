defmodule CbusElixirWeb.UserController do
  use CbusElixirWeb, :controller

  import CbusElixirWeb.Authorize
  alias Phauxth.Log
  alias CbusElixir.Accounts
  alias CbusElixirWeb.Email
  alias CbusElixirWeb.Mailer
  alias Phauxth.Login

  # the following plugs are defined in the controllers/authorize.ex file
  plug :user_check when action in [:index, :show]
  plug :id_check when action in [:edit, :update, :delete]
  plug :is_admin? when action in [:index, :admin]

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
    render(conn, "show.html", user: user)
  end

  def edit(%Plug.Conn{assigns: %{current_user: user}} = conn, _) do
    changeset = Accounts.change_user(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(%Plug.Conn{assigns: %{current_user: user}} = conn, %{"user" => user_params}) do
    case Accounts.update_user(user, user_params) do
      {:ok, user} ->
        success(conn, "User updated successfully", user_path(conn, :show, user))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(%Plug.Conn{assigns: %{current_user: user}} = conn, _) do
    {:ok, _user} = Accounts.delete_user(user)

    delete_session(conn, :phauxth_session_id)
    |> success("User deleted successfully", session_path(conn, :new))
  end

  def admin(conn, params) do
    page = Accounts.list_users_paged(params)
    render(conn, "admin.html", users: page.entries, page: page)
  end
end
