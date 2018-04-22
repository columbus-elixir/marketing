defmodule CbusElixir.App.Speaker do
  use Ecto.Schema
  import Ecto.Query
  import Ecto.Changeset
  alias CbusElixir.App.Speaker


  schema "speakers" do
    field :title, :string
    field :url, :string
    field :status, :string, default: "Open"
    belongs_to :meeting, CbusElixir.App.Meeting
    belongs_to :user, CbusElixir.Accounts.User
    timestamps()
  end

  @doc false
  def changeset(%Speaker{} = speaker, attrs) do
    speaker
    |> cast(attrs, [:url, :title, :status, :meeting_id, :user_id])
    |> validate_required([:url, :title, :meeting_id, :user_id])
  end
end
