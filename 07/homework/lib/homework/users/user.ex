defmodule Homework.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Homework.Meetings.Meeting
  schema "users" do
    field :username, :string
    many_to_many :meetings, Meeting, join_through: "user_meetings"

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username])
    |> validate_required([:username])
  end
end
