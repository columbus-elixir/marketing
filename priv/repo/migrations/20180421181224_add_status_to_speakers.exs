defmodule CbusElixir.Repo.Migrations.AddStatusToSpeakers do
  use Ecto.Migration

  def change do
    alter table(:speakers) do
      add :status, :string
    end
  end
end
