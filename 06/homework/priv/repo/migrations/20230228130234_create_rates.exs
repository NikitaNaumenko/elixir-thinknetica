defmodule Homework.Repo.Migrations.CreateRates do
  use Ecto.Migration

  def change do
    create table(:rates) do
      timestamps()
    end
  end
end
