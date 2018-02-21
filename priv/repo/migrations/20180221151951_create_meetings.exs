defmodule CbusElixir.Repo.Migrations.CreateMeetings do
  use Ecto.Migration

  def change do
    create table(:meetings) do
      add :location, :string
      add :address, :string
      add :date, :string

      timestamps()
    end

  end
end
