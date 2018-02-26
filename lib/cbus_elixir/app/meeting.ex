defmodule CbusElixir.App.Meeting do
  use Ecto.Schema
  import Ecto.Changeset
  alias CbusElixir.App.Meeting


  schema "meetings" do
    field :date, :utc_datetime
    has_many :speakers, CbusElixir.App.Speaker

    timestamps()
  end

  @doc false
  def changeset(%Meeting{} = meeting, attrs) do
    meeting
    |> cast(attrs, [:date])
    |> validate_required([:date])
  end
end
