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
    |> cast(attrs, [:name, :email, :twitter, :new_to_elixir, :new_to_cbus_elixir, :meeting_id])
    |> validate_required([:name, :email, :new_to_elixir, :new_to_cbus_elixir, :meeting_id])
    |> validate_length(:twitter, min: 1, max: 15)
    |> validate_format(:email, ~r/@/)
    |> format_twitter
  end

  defp format_twitter(%{valid?: false} = changeset), do: changeset

  defp format_twitter(changeset) do
    twitter = get_change(changeset, :twitter)
    invalid_handle_input = Regex.scan(~r/[^\w+?\@]/, twitter)
    
    if length(invalid_handle_input) > 0 do
      Ecto.Changeset.add_error(changeset, :twitter, "Characters #{invalid_handle_input} not allowed in Twitter handle")
    else
      put_change(changeset, :twitter, Regex.replace(~r/\W+/, twitter, ""))
    end
  end

end