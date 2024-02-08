defmodule Reciper.Recipes.Ingredient do
  use Ecto.Schema
  import Ecto.Changeset

  schema "ingredients" do
    field :name, :string
    field :category, Ecto.Enum, values: [:vegetable, :dairy, :meat, :grains, :nuts, :fish, :sweet, :egg]

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(ingredient, attrs) do
    ingredient
    |> cast(attrs, [:name, :category])
    |> validate_required([:name, :category])
  end
end
