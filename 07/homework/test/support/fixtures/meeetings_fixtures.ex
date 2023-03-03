defmodule Homework.MeetingsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Homework.Meetings` context.
  """

  @doc """
  Generate a meeting.
  """
  def meeting_fixture(attrs \\ %{}) do
    {:ok, meeting} =
      attrs
      |> Enum.into(%{

      })
      |> Homework.Meetings.create_meeting()

    meeting
  end
end
