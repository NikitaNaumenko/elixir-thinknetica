defmodule Homework.MeetingsTest do
  use Homework.DataCase

  alias Homework.Meetings

  describe "meetings" do
    alias Homework.Meetings.Meeting

    import Homework.MeetingsFixtures

    @invalid_attrs %{name: nil}
    @valid_attrs %{name: "123", scheduled_at: NaiveDateTime.utc_now()}

    test "list_meetings/0 returns all meetings" do
      meeting = meeting_fixture(@valid_attrs) |> Homework.Repo.preload([:users])
      assert Meetings.list_meetings() == [meeting]
    end

    test "get_meeting!/1 returns the meeting with given id" do
      meeting = meeting_fixture(@valid_attrs)
      assert Meetings.get_meeting!(meeting.id) == meeting
    end

    test "create_meeting/1 with valid data creates a meeting" do
      assert {:ok, %Meeting{}} = Meetings.create_meeting(@valid_attrs)
    end

    test "create_meeting/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Meetings.create_meeting(@invalid_attrs)
    end

    test "update_meeting/2 with valid data updates the meeting" do
      meeting = meeting_fixture(@valid_attrs)
      update_attrs = %{name: "223", scheduled_at: NaiveDateTime.utc_now()}

      assert {:ok, %Meeting{}} = Meetings.update_meeting(meeting, update_attrs)
    end

    test "update_meeting/2 with invalid data returns error changeset" do
      meeting = meeting_fixture(@valid_attrs)
      assert {:error, %Ecto.Changeset{}} = Meetings.update_meeting(meeting, @invalid_attrs)
      assert meeting == Meetings.get_meeting!(meeting.id)
    end

    test "delete_meeting/1 deletes the meeting" do
      meeting = meeting_fixture(@valid_attrs)
      assert {:ok, %Meeting{}} = Meetings.delete_meeting(meeting)
      assert_raise Ecto.NoResultsError, fn -> Meetings.get_meeting!(meeting.id) end
    end

    test "change_meeting/1 returns a meeting changeset" do
      meeting = meeting_fixture(@valid_attrs)
      assert %Ecto.Changeset{} = Meetings.change_meeting(meeting)
    end
  end
end
