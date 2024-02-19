defmodule Reciper.Repo.Migrations.UpdateRecipeModel do
  use Ecto.Migration

  def change do
    alter table(:recipes) do
      add :description, :string
    end

    create table(:recipe_ingredient_quantity) do
      add :ingredient_quantity_id, references("ingredient_quantities")
      add :recipe_id, references("recipes")
    end
  end
end
