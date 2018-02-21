defmodule CbusElixir.App.Speaker do
  use Ecto.Schema
  import Ecto.Changeset
  alias CbusElixir.App.Speaker
  alias CbusElixir.App.Meeting


  schema "speakers" do
    field :email, :string
    field :meeting_id, :integer
    field :name, :string
    field :title, :string
    field :url, :string
    many_to_many :meetings, Meeting, join_through: "meeting_speakers"

    timestamps()
  end

  @doc false
  def changeset(%Speaker{} = speaker, attrs) do
    speaker
    |> cast(attrs, [:name, :url, :title, :email, :meeting_id])
    |> validate_required([:name, :url, :title, :email, :meeting_id])
  end
end
