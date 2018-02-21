defmodule CbusElixir.AppTest do
  use CbusElixir.DataCase

  alias CbusElixir.App

  describe "meetings" do
    alias CbusElixir.App.Meeting

    @valid_attrs %{address: "some address", date: "some date", location: "some location"}
    @update_attrs %{address: "some updated address", date: "some updated date", location: "some updated location"}
    @invalid_attrs %{address: nil, date: nil, location: nil}

    def meeting_fixture(attrs \\ %{}) do
      {:ok, meeting} =
        attrs
        |> Enum.into(@valid_attrs)
        |> App.create_meeting()

      meeting
    end

    test "list_meetings/0 returns all meetings" do
      meeting = meeting_fixture()
      assert App.list_meetings() == [meeting]
    end

    test "get_meeting!/1 returns the meeting with given id" do
      meeting = meeting_fixture()
      assert App.get_meeting!(meeting.id) == meeting
    end

    test "create_meeting/1 with valid data creates a meeting" do
      assert {:ok, %Meeting{} = meeting} = App.create_meeting(@valid_attrs)
      assert meeting.address == "some address"
      assert meeting.date == "some date"
      assert meeting.location == "some location"
    end

    test "create_meeting/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = App.create_meeting(@invalid_attrs)
    end

    test "update_meeting/2 with valid data updates the meeting" do
      meeting = meeting_fixture()
      assert {:ok, meeting} = App.update_meeting(meeting, @update_attrs)
      assert %Meeting{} = meeting
      assert meeting.address == "some updated address"
      assert meeting.date == "some updated date"
      assert meeting.location == "some updated location"
    end

    test "update_meeting/2 with invalid data returns error changeset" do
      meeting = meeting_fixture()
      assert {:error, %Ecto.Changeset{}} = App.update_meeting(meeting, @invalid_attrs)
      assert meeting == App.get_meeting!(meeting.id)
    end

    test "delete_meeting/1 deletes the meeting" do
      meeting = meeting_fixture()
      assert {:ok, %Meeting{}} = App.delete_meeting(meeting)
      assert_raise Ecto.NoResultsError, fn -> App.get_meeting!(meeting.id) end
    end

    test "change_meeting/1 returns a meeting changeset" do
      meeting = meeting_fixture()
      assert %Ecto.Changeset{} = App.change_meeting(meeting)
    end
  end
end
