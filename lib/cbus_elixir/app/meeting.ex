defmodule CbusElixir.App.Meeting do
  use Ecto.Schema
  import Ecto.Changeset
  alias CbusElixir.App.Meeting


  schema "meetings" do
    field :address, :string
    field :date, :string
    field :location, :string

    timestamps()
  end

  @doc false
  def changeset(%Meeting{} = meeting, attrs) do
    meeting
    |> cast(attrs, [:location, :address, :date])
    |> validate_required([:location, :address, :date])
  end
end
