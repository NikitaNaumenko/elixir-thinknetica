defmodule Homework.Meetings.Meeting do
  use Ecto.Schema
  import Ecto.Changeset

  alias Homework.Users.User
  alias Homework.Users

  schema "meetings" do
    field :name, :string
    field :scheduled_at, :naive_datetime

    has_many :user_meetings, Users.Meeting
    many_to_many :users, User, join_through: "user_meetings"

    timestamps()
  end

  @doc false
  def changeset(meeting, attrs) do
    meeting
    |> cast(attrs, [:name, :scheduled_at])
    |> cast_assoc(:user_meetings)
    # |> validate_required([:name, :scheduled_at])
  end
end
