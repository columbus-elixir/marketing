defmodule CbusElixir.App.Attendee do
  use Ecto.Schema
  import Ecto.Changeset
  alias CbusElixir.App.{Meeting, Attendee}

  schema "attendees" do
    field(:email, :string)
    field(:name, :string)
    field(:new_to_cbus_elixir, :boolean, default: false)
    field(:new_to_elixir, :boolean, default: false)
    field(:twitter, :string)
    belongs_to(:meeting, Meeting)

    timestamps()
  end

  @doc false
  def changeset(%Attendee{} = attendee, attrs) do
    attendee
    |> cast(attrs, [:name, :email, :twitter, :new_to_elixir, :new_to_cbus_elixir, :meeting_id])
    |> validate_required([:name, :email, :new_to_elixir, :new_to_cbus_elixir, :meeting_id])
    |> validate_format(:email, ~r/@/, message: "Email must contain '@'")
    |> validate_length(:twitter, min: 1, max: 15)
    |> format_twitter
  end

  defp format_twitter(%{valid?: false} = changeset), do: changeset

  defp format_twitter(%{changes: %{twitter: handle}} = changeset) do
    invalid_handle_input = Regex.scan(~r/[^\w+?\@]/, handle)

    if length(invalid_handle_input) > 0 do
      add_error(
        changeset,
        :twitter,
        "Characters #{invalid_handle_input} not allowed in Twitter handle"
      )
    else
      put_change(changeset, :twitter, Regex.replace(~r/\W+/, handle, ""))
    end
  end

  defp format_twitter(changeset), do: changeset
end
