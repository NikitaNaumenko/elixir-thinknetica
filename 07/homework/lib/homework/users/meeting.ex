defmodule Homework.Users.Meeting do
  use Ecto.Schema
  import Ecto.Changeset

  alias Homework.Users.User
  alias Homework.Meetings.Meeting

  schema "user_meetings" do
    belongs_to :user, User
    belongs_to :meeting, Meeting

    timestamps()
  end

  @doc false
  def changeset(meeting, attrs) do
    meeting
    |> cast(attrs, [:user_id, :meeting_id])
    |> assoc_constraint(:user)
    |> assoc_constraint(:meeting)
    # |> validate_required([:user_id, :meeting_id])
    |> unique_constraint([:user_id, :meeting_id])
  end
end
