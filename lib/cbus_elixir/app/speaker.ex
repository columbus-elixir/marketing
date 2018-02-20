defmodule CbusElixir.App.Speaker do
  use Ecto.Schema
  import Ecto.Changeset
  alias CbusElixir.App.Speaker


  schema "speakers" do
    field :name, :string
    field :title, :string
    field :url, :string
    field :email, :string

    timestamps()
  end

  @doc false
  def changeset(%Speaker{} = speaker, attrs) do
    speaker
    |> cast(attrs, [:name, :url, :title, :email])
    |> validate_required([:name, :url, :title, :email])
  end
end
