defmodule CbusElixir.App.Meeting do
  use Ecto.Schema
  import Ecto.Changeset
  alias CbusElixir.App.Meeting
  alias CbusElixir.App.Speaker


  schema "meetings" do
    field :date, :utc_datetime
    many_to_many :speakers, Speaker, join_through: "meeting_speakers"

    timestamps()
  end

  @doc false
  def changeset(%Meeting{} = meeting, attrs) do
    meeting
    |> cast(attrs, [:date])
    |> validate_required([:date])
  end
end
