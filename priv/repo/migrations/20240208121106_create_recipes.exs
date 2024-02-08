defmodule Reciper.Repo.Migrations.CreateRecipes do
  use Ecto.Migration

  def change do
    create table(:recipes) do
      add :name, :string
      add :preparing_time_minutes, :integer
      add :portions, :integer
      add :vegan, :boolean, default: false, null: false
      add :vegetarian, :boolean, default: false, null: false
      add :one_pot_recipe, :boolean, default: false, null: false

      timestamps(type: :utc_datetime)
    end
  end
end
