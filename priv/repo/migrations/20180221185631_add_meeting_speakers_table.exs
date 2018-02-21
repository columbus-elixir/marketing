defmodule CbusElixir.Repo.Migrations.AddMeetingSpeakersTable do
  use Ecto.Migration

  def change do
    create table(:meeting_speakers, primary_key: false) do
      add :speaker_id, references(:speakers)
      add :meeting_id, references(:meetings)
    end
  end
end
