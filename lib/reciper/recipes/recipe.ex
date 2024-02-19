defmodule Reciper.Recipes.Recipe do
  alias Reciper.Recipes.IngredientQuantity
  use Ecto.Schema
  import Ecto.Changeset

  schema "recipes" do
    field :name, :string
    field :preparing_time_minutes, :integer
    field :portions, :integer
    field :vegan, :boolean, default: false
    field :vegetarian, :boolean, default: false
    field :one_pot_recipe, :boolean, default: false

    many_to_many :ingredient_quantities, IngredientQuantity,
      join_through: "recipe_ingredient_quantity"

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(recipe, attrs) do
    recipe
    |> cast(attrs, [
      :name,
      :preparing_time_minutes,
      :portions,
      :vegan,
      :vegetarian,
      :one_pot_recipe
    ])
    |> validate_required([
      :name,
      :preparing_time_minutes,
      :portions,
      :vegan,
      :vegetarian,
      :one_pot_recipe
    ])
  end
end
