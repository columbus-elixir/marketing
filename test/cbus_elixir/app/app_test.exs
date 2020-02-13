defmodule CbusElixir.AppTest do
  use CbusElixir.DataCase

  alias CbusElixir.App
  alias CbusElixir.App.Meeting

  describe "speakers" do
    alias CbusElixir.App.Speaker

    @valid_attrs %{
      email: "some email",
      name: "some name",
      title: "some title",
      url: "some url"
    }
    @update_attrs %{
      email: "some updated email",
      name: "some updated name",
      title: "some updated title",
      url: "some updated url"
    }
    @invalid_attrs %{email: nil, meeting_id: nil, name: nil, title: nil, url: nil}

    def speaker_fixture(attrs \\ %{}) do
      {:ok, speaker} =
        attrs
        |> Enum.into(@valid_attrs)
        |> App.create_speaker()

      speaker
    end

    def meeting_id() do
      %Meeting{}
      |> Meeting.changeset(%{date: NaiveDateTime.utc_now()})
      |> Repo.insert!()
      |> Map.get(:id)
    end

    test "list_speakers/0 returns all speakers" do
      speaker =
        speaker_fixture(%{meeting_id: meeting_id()})
        |> Repo.preload([:meeting])

      assert App.list_speakers() == [speaker]
    end

    test "get_speaker!/1 returns the speaker with given id" do
      speaker =
        speaker_fixture(%{meeting_id: meeting_id()})
        |> Repo.preload([:meeting])

      assert App.get_speaker!(speaker.id) == speaker
    end

    test "create_speaker/1 with valid data creates a speaker" do
      meeting_id = meeting_id()

      {:ok, %Speaker{} = speaker} =
        %{meeting_id: meeting_id}
        |> Enum.into(@valid_attrs)
        |> App.create_speaker()

      assert speaker.email == "some email"
      assert speaker.meeting_id == meeting_id
      assert speaker.name == "some name"
      assert speaker.title == "some title"
      assert speaker.url == "some url"
    end

    test "create_speaker/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = App.create_speaker(@invalid_attrs)
    end

    test "update_speaker/2 with valid data updates the speaker" do
      meeting_id = meeting_id()
      speaker = speaker_fixture(%{meeting_id: meeting_id})
      assert {:ok, speaker} = App.update_speaker(speaker, @update_attrs)
      assert %Speaker{} = speaker
      assert speaker.email == "some updated email"
      assert speaker.meeting_id == meeting_id
      assert speaker.name == "some updated name"
      assert speaker.title == "some updated title"
      assert speaker.url == "some updated url"
    end

    test "update_speaker/2 with invalid data returns error changeset" do
      speaker =
        speaker_fixture(%{meeting_id: meeting_id()})
        |> Repo.preload([:meeting])

      assert {:error, %Ecto.Changeset{}} = App.update_speaker(speaker, @invalid_attrs)
      assert App.get_speaker!(speaker.id) == speaker
    end

    test "delete_speaker/1 deletes the speaker" do
      speaker = speaker_fixture(%{meeting_id: meeting_id()})
      assert {:ok, %Speaker{}} = App.delete_speaker(speaker)
      assert_raise Ecto.NoResultsError, fn -> App.get_speaker!(speaker.id) end
    end

    test "change_speaker/1 returns a speaker changeset" do
      speaker = speaker_fixture(%{meeting_id: meeting_id()})
      assert %Ecto.Changeset{} = App.change_speaker(speaker)
    end
  end

  describe "attendees" do
    alias CbusElixir.App.Attendee

    @valid_attrs %{
      email: "some@email",
      name: "some name",
      new_to_cbus_elixir: true,
      new_to_elixir: true,
      twitter: "@handle",
      meeting_id: 1
    }
    @invalid_attrs %{email: nil, name: nil, new_to_cbus_elixir: nil, new_to_elixir: nil}

    def attendee_fixture(attrs \\ %{}) do
      {:ok, attendee} =
        attrs
        |> Enum.into(@valid_attrs)
        |> App.create_attendee()

      attendee
    end

    test "list_attendees/0 returns all attendees" do
      attendee = attendee_fixture(%{meeting_id: meeting_id()})
      assert App.list_attendees() == [attendee]
    end

    test "get_attendee!/1 returns the attendee with given id" do
      attendee = attendee_fixture(%{meeting_id: meeting_id()})
      assert App.get_attendee!(attendee.id) == attendee
    end

    test "create_attendee/1 with valid data creates a attendee" do
      meeting_id = meeting_id()

      {:ok, %Attendee{} = attendee} =
        %{meeting_id: meeting_id}
        |> Enum.into(@valid_attrs)
        |> App.create_attendee()

      assert attendee.email == "some@email"
      assert attendee.name == "some name"
      assert attendee.new_to_cbus_elixir == true
      assert attendee.new_to_elixir == true
      assert attendee.meeting_id == meeting_id
      assert attendee.twitter == "handle"
    end

    test "create_attendee/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = App.create_attendee(@invalid_attrs)
    end
  end

  describe "meetings" do
    alias CbusElixir.App.Meeting

    @valid_attrs %{
      date: %{
        day: "1",
        month: "1",
        year: "2000"
      },
      rsvp_link: "https://columbuselixir.com"
    }
    @invalid_attrs %{
      date: %{}
    }

    def meeting_fixture(attrs \\ %{}) do
      {:ok, meeting} =
        attrs
        |> Enum.into(@valid_attrs)
        |> App.create_meeting()

      meeting
    end

    test "update_meeting/2 with invalid data returns error changeset" do
      meeting = meeting_fixture()
  
      assert {:error, %Ecto.Changeset{}} = App.update_meeting(meeting, @invalid_attrs)
      assert App.get_meeting!(meeting.id) == meeting
    end

    test "get_meeting!/1 returns the meeting with given id" do
      meeting = meeting_fixture()

      assert App.get_meeting!(meeting.id) == meeting
    end

    test "create_meeting/1 with valid data creates a meeting" do
      meeting = meeting_fixture()

      assert meeting.date == ~D[2000-01-01]
      assert meeting.rsvp_link == "https://columbuselixir.com"
    end

    test "delete_meeting/1 deletes the meeting" do
      meeting = meeting_fixture()
      assert {:ok, %Meeting{}} = App.delete_meeting(meeting)
      assert_raise Ecto.NoResultsError, fn -> App.get_meeting!(meeting.id) end
    end
  end
end
