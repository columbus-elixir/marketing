defmodule CbusElixir.Accounts do
  @moduledoc """
  The boundary for the Accounts system.
  """

  import Ecto.{Query, Changeset}, warn: false
  alias CbusElixir.{Accounts.User, Repo}

  def list_users do
    Repo.all(User)
  end

  def get(id), do: Repo.get(User, id)

  def get_by(%{"email" => email}) do
    Repo.get_by(User, email: email)
  end

  def create_user(attrs) do
    %User{}
    |> User.create_changeset(attrs)
    |> Repo.insert()
  end

  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  def list_sessions(user_id) do
    with user when is_map(user) <- Repo.get(User, user_id), do: user.sessions
  end

  def add_session(%User{sessions: sessions} = user, session_id, timestamp) do
    change(user, sessions: put_in(sessions, [session_id], timestamp))
    |> Repo.update
  end

  def delete_session(%User{sessions: sessions} = user, session_id) do
    change(user, sessions: Map.delete(sessions, session_id))
    |> Repo.update
  end

  def remove_old_sessions(session_age) do
    now = System.system_time(:second)
    Enum.map(
      list_users(),
      &(change(
          &1,
          sessions:
            :maps.filter(
              fn _, time ->
                time + session_age > now
              end,
              &1.sessions
            )
        )
        |> Repo.update())
    )
  end
end
