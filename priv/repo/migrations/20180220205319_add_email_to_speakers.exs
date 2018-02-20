defmodule CbusElixir.Repo.Migrations.AddEmailToSpeakers do
  use Ecto.Migration

  def change do
    alter table(:speakers) do
      add :email, :string
    end
  end
end
