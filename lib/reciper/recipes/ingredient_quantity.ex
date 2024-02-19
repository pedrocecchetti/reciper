defmodule Reciper.Recipes.IngredientQuantity do
  alias Reciper.Recipes.Recipe
  alias Reciper.Recipes.Ingredient
  use Ecto.Schema
  import Ecto.Changeset

  schema "ingredient_quantities" do
    field :measurement, Ecto.Enum, values: [:g, :kg, :l, :ml, :tbsp, :tsp, :cup, :dash]
    field :quantity, :integer
    field :ingredient_id, :id

    has_one :ingredient, Ingredient, foreign_key: :id, references: :ingredient_id
    many_to_many :recipe, Recipe, join_through: :recipe_ingredient_quantity

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(ingredient_quantity, attrs) do
    ingredient_quantity
    |> cast(attrs, [:measurement, :quantity, :ingredient_id])
    |> validate_required([:measurement, :quantity, :ingredient_id])
    |> unique_constraint([:ingredient_id, :quantity, :measurement],
      message: "This ingredient quantity already exists! "
    )
  end

  def update_changeset(ingredient_quantity, attrs) do
    ingredient_quantity
    |> cast(attrs, [:quantity, :measurement])
    |> validate_required([:measurement, :quantity])
    |> unique_constraint([:ingredient_id, :quantity, :measurement],
      message: "This ingredient quantity already exists! "
    )
  end
end
