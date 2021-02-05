defmodule CbusElixir.Repo.Migrations.ChangeMeetingDateToDate do
  use Ecto.Migration

  def change do
    alter table(:meetings) do
      modify(:date, :date)
    end
  end
end
