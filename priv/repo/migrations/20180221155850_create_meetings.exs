defmodule CbusElixir.Repo.Migrations.CreateMeetings do
  use Ecto.Migration

  def change do
    create table(:meetings) do
      add :date, :utc_datetime
      timestamps()
    end
  end

end
