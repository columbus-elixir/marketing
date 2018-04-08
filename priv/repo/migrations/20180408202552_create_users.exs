defmodule CbusElixir.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :first_name, :string
      add :last_name, :string
      add :email, :string
      add :password_hash, :string
      add :sessions, {:map, :integer}, default: "{}"

      timestamps()
    end

    create unique_index :users, [:email]
  end
end
