defmodule CbusElixir.Repo.Migrations.UpdateAttendeesTable do
  use Ecto.Migration

  def change do
    alter table(:attendees) do
      modify(:name, :string, null: false)
      modify(:email, :string, null: false)
    end
  end
end
