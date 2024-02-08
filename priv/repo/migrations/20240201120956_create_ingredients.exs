defmodule Reciper.Repo.Migrations.CreateIngredients do
  use Ecto.Migration

  def change do
    create table(:ingredients) do
      add :name, :string
      add :category, :string

      timestamps(type: :utc_datetime)
    end
  end
end
