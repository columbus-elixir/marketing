defmodule CbusElixir.App do
  @moduledoc """
  The App context.
  """

  import Ecto.Query, warn: false
  alias CbusElixir.Repo

  alias CbusElixir.App.Speaker
  alias CbusElixir.App.Meetings

  @doc """
  Returns the list of speakers.

  ## Examples

      iex> list_speakers()
      [%Speaker{}, ...]

  """
  def list_speakers do
    Repo.all(Speaker)
  end

  @doc """
  Gets a single speaker.

  Raises `Ecto.NoResultsError` if the Speaker does not exist.

  ## Examples

      iex> get_speaker!(123)
      %Speaker{}

      iex> get_speaker!(456)
      ** (Ecto.NoResultsError)

  """
  def get_speaker!(id), do: Repo.get!(Speaker, id)

  @doc """
  Creates a speaker.

  ## Examples

      iex> create_speaker(%{field: value})
      {:ok, %Speaker{}}

      iex> create_speaker(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_speaker(attrs \\ %{}) do
    %Speaker{}
    |> Speaker.changeset(attrs)
    |> Repo.insert()
  end

  @doc """

  Updates a speaker.

  ## Examples

      iex> update_speaker(speaker, %{field: new_value})
      {:ok, %Speaker{}}

      iex> update_speaker(speaker, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_speaker(%Speaker{} = speaker, attrs) do
    speaker
    |> Speaker.changeset(attrs)
    |> Repo.update()
  end

  @doc """

  Deletes a Speaker.

  ## Examples

      iex> delete_speaker(speaker)
      {:ok, %Speaker{}}

      iex> delete_speaker(speaker)
      {:error, %Ecto.Changeset{}}

  """
  def delete_speaker(%Speaker{} = speaker) do
    Repo.delete(speaker)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking speaker changes.

  ## Examples

      iex> change_speaker(speaker)
      %Ecto.Changeset{source: %Speaker{}}

  """
  def change_speaker(%Speaker{} = speaker) do
    Speaker.changeset(speaker, %{})
  end

  @doc """
  Returns a list of approved speakers
  ## Examples
    iex> list_approved_speakers()
    [%Speaker{status: "Approved"}, ...]
  """
  def list_speakers_by_status(status) do
    query = from s in Speaker,
    where: s.status == ^status
    Repo.all(query)
  end

  def list_approved_speakers_by_meeting(meeting) do
    query = from s in Speaker,
    where: s.meeting_id == ^meeting.id and s.status == "Approved"
    Repo.all(query)
  end

  def this_users_speaking_requests(user) do
    query = from s in Speaker,
    where: s.user_id == ^user.id
    Repo.all(query)
  end

end
