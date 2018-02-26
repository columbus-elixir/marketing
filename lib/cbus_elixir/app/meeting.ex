defmodule CbusElixir.App.Meeting do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias CbusElixir.App.Meeting

  schema "meetings" do
    field :date, :utc_datetime
    has_many :speakers, CbusElixir.App.Speaker

    timestamps()
  end

  def happening_after(query, date) do
    query
    |> where([m], m.date > type(^date, Ecto.Date))
    |> order_by(asc: :date)
  end

  @doc false
  def changeset(%Meeting{} = meeting, attrs) do
    meeting
    |> cast(attrs, [:date])
    |> validate_required([:date])
  end
end