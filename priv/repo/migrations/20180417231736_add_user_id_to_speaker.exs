defmodule CbusElixir.Repo.Migrations.AddUserIdToSpeaker do
  use Ecto.Migration

  def change do
    alter table(:speakers) do
      add :user_id, references(:users)
    end
  end
end
