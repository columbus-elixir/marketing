defmodule CbusElixir.Repo.Migrations.SpeakerBelongsToMeeting do
  use Ecto.Migration

  def change do
    alter table(:speakers) do
      add :meeting_id, references(:meetings)
    end
  end
end
