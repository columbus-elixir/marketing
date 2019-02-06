defmodule CbusElixir.Repo.Migrations.AddUniqueConstraintToEmail do
  use Ecto.Migration

  def change do
    create unique_index(:attendees, [:email])
  end
end
