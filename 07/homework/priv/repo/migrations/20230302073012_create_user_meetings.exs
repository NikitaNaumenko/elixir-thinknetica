defmodule Homework.Repo.Migrations.CreateUserMeetings do
  use Ecto.Migration

  def change do
    create table(:user_meetings) do
      add :user_id, references(:users)
      add :meeting_id, references(:meetings, on_delete: :delete_all)

      timestamps()
    end

    create unique_index(:user_meetings, [:user_id, :meeting_id])
  end
end
