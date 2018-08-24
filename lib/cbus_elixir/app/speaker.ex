defmodule CbusElixir.App.Speaker do
  use Ecto.Schema
  import Ecto.Changeset
  alias CbusElixir.App.Speaker

  schema "speakers" do
    field(:email, :string)
    field(:name, :string)
    field(:title, :string)
    field(:url, :string)
    belongs_to(:meeting, CbusElixir.App.Meeting)

    timestamps()
  end

  @doc false
  def changeset(%Speaker{} = speaker, attrs) do
    speaker
    |> cast(attrs, [:name, :url, :title, :email, :meeting_id])
    |> validate_required([:name, :url, :title, :email, :meeting_id])
  end
end
