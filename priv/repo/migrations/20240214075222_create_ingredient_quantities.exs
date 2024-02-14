defmodule Reciper.Repo.Migrations.CreateIngredientQuantities do
  use Ecto.Migration

  def change do
    create table(:ingredient_quantities) do
      add :measurement, :string
      add :quantity, :integer
      add :ingredient_id, references(:ingredients, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create unique_index(:ingredient_quantities, [:ingredient_id, :quantity, :measurement])
  end
end
