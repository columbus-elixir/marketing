defmodule CbusElixir.Repo.Migrations.CreateSpeakers do
  use Ecto.Migration

  def change do
    create table(:speakers) do
      add :name, :string
      add :url, :string
      add :title, :string

      timestamps()
    end

  end
end
