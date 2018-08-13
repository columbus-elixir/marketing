defmodule CbusElixir.App.Attendee do
  use Ecto.Schema
  import Ecto.Changeset
  alias CbusElixir.App.{ Meeting, Attendee }


  schema "attendees" do
    field :email, :string
    field :name, :string
    field :new_to_cbus_elixir, :boolean, default: false
    field :new_to_elixir, :boolean, default: false
    field :twitter, :string
    belongs_to :meeting, Meeting

    timestamps()
  end

  @doc false
  def changeset(%Attendee{} = attendee, attrs) do
    attendee
    |> cast(attrs, [:name, :email, :twitter, :new_to_elixir, :new_to_cbus_elixir])
    |> validate_required([:name, :email, :twitter, :new_to_elixir, :new_to_cbus_elixir])
  end
end
