defmodule CbusElixir.AppTest do
  use CbusElixir.DataCase

  alias CbusElixir.App


  describe "speakers" do
    alias CbusElixir.App.Speaker

    @valid_attrs %{email: "some email", meeting_id: 42, name: "some name", title: "some title", url: "some url"}
    @update_attrs %{email: "some updated email", meeting_id: 43, name: "some updated name", title: "some updated title", url: "some updated url"}
    @invalid_attrs %{email: nil, meeting_id: nil, name: nil, title: nil, url: nil}

    def speaker_fixture(attrs \\ %{}) do
      {:ok, speaker} =
        attrs
        |> Enum.into(@valid_attrs)
        |> App.create_speaker()

      speaker
    end

    test "list_speakers/0 returns all speakers" do
      speaker = speaker_fixture()
      assert App.list_speakers() == [speaker]
    end

    test "get_speaker!/1 returns the speaker with given id" do
      speaker = speaker_fixture()
      assert App.get_speaker!(speaker.id) == speaker
    end

    test "create_speaker/1 with valid data creates a speaker" do
      assert {:ok, %Speaker{} = speaker} = App.create_speaker(@valid_attrs)
      assert speaker.email == "some email"
      assert speaker.meeting_id == 42
      assert speaker.name == "some name"
      assert speaker.title == "some title"
      assert speaker.url == "some url"
    end

    test "create_speaker/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = App.create_speaker(@invalid_attrs)
    end

    test "update_speaker/2 with valid data updates the speaker" do
      speaker = speaker_fixture()
      assert {:ok, speaker} = App.update_speaker(speaker, @update_attrs)
      assert %Speaker{} = speaker
      assert speaker.email == "some updated email"
      assert speaker.meeting_id == 43
      assert speaker.name == "some updated name"
      assert speaker.title == "some updated title"
      assert speaker.url == "some updated url"
    end

    test "update_speaker/2 with invalid data returns error changeset" do
      speaker = speaker_fixture()
      assert {:error, %Ecto.Changeset{}} = App.update_speaker(speaker, @invalid_attrs)
      assert speaker == App.get_speaker!(speaker.id)
    end

    test "delete_speaker/1 deletes the speaker" do
      speaker = speaker_fixture()
      assert {:ok, %Speaker{}} = App.delete_speaker(speaker)
      assert_raise Ecto.NoResultsError, fn -> App.get_speaker!(speaker.id) end
    end

    test "change_speaker/1 returns a speaker changeset" do
      speaker = speaker_fixture()
      assert %Ecto.Changeset{} = App.change_speaker(speaker)

    end
  end

  describe "attendees" do
    alias CbusElixir.App.Attendee

    @valid_attrs %{email: "some@email", name: "some name", new_to_cbus_elixir: true, new_to_elixir: true, twitter: "@handle", meeting_id: 1}
    @invalid_attrs %{email: nil, name: nil, new_to_cbus_elixir: nil, new_to_elixir: nil}

    def attendee_fixture(attrs \\ %{}) do
      {:ok, attendee} =
        attrs
        |> Enum.into(@valid_attrs)
        |> App.create_attendee()

      attendee
    end

    test "list_attendees/0 returns all attendees" do
      attendee = attendee_fixture()
      assert App.list_attendees() == [attendee]
    end

    test "get_attendee!/1 returns the attendee with given id" do
      attendee = attendee_fixture()
      assert App.get_attendee!(attendee.id) == attendee
    end

    test "create_attendee/1 with valid data creates a attendee" do
      assert {:ok, %Attendee{} = attendee} = App.create_attendee(@valid_attrs)
      assert attendee.email == "some@email"
      assert attendee.name == "some name"
      assert attendee.new_to_cbus_elixir == true
      assert attendee.new_to_elixir == true
      assert attendee.meeting_id == 1
      assert attendee.twitter == "handle"
    end

    test "create_attendee/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = App.create_attendee(@invalid_attrs)
    end

  end
end
