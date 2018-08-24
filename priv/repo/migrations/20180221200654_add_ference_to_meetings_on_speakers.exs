defmodule CbusElixir.Repo.Migrations.AddFerenceToMeetingsOnSpeakers do
  use Ecto.Migration

  def change do
    alter table(:speakers) do
      modify(:meeting_id, references(:meetings))
    end
  end
end
