defmodule CbusElixir.Repo.Migrations.AddRsvpLinkToMeetings do
  use Ecto.Migration

  def change do
    alter table(:meetings) do
      add :rsvp_link, :text
    end
  end
end
