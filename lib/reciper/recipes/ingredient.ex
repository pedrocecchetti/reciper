defmodule Reciper.Recipes.Ingredient do
  use Ecto.Schema
  import Ecto.Changeset

  schema "ingredients" do
    field :name, :string

    field :category, Ecto.Enum,
      values: [:vegetable, :dairy, :meat, :grains, :nuts, :fish, :sweet, :egg]

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(ingredient, attrs) do
    ingredient
    |> cast(attrs, [:name, :category])
    |> update_change(:name, &String.capitalize(&1))
    |> validate_length(:name, min: 2)
    |> validate_required([:name, :category])
    |> unique_constraint(:name, message: "Ingredient with same name already registered")
  end
end
