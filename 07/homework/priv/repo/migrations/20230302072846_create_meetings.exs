defmodule Homework.Repo.Migrations.CreateMeetings do
  use Ecto.Migration

  def change do
    create table(:meetings) do
      add :name, :string
      add :scheduled_at, :naive_datetime

      timestamps()
    end
  end
end
