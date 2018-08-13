defmodule CbusElixir.Repo.Migrations.CreateAttendees do
  use Ecto.Migration

  def change do
    create table(:attendees) do
      add :name, :string
      add :email, :string
      add :twitter, :string
      add :new_to_elixir, :boolean, default: false, null: false
      add :new_to_cbus_elixir, :boolean, default: false, null: false
      add :meeting_id, references :meetings

      timestamps()
    end

  end
end
