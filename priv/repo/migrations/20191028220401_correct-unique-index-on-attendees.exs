defmodule :"Elixir.CbusElixir.Repo.Migrations.Correct-unique-index-on-attendees" do
  use Ecto.Migration

  def change do
    drop(index(:attendees, [:email]))
    create(unique_index(:attendees, [:email, :meeting_id]))
  end
end
