defmodule Reciper.RecipesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Reciper.Recipes` context.
  """

  alias Reciper.Repo

  @doc """
  Generate a ingredient.
  """
  def ingredient_fixture(attrs \\ %{}) do
    {:ok, ingredient} =
      attrs
      |> Enum.into(%{
        category: :vegetable,
        name: "some name"
      })
      |> Reciper.Recipes.create_ingredient()

    ingredient
  end

  @doc """
  Generate a recipe.
  """
  def recipe_fixture(attrs \\ %{}) do
    {:ok, recipe} =
      attrs
      |> Enum.into(%{
        name: "some name",
        one_pot_recipe: true,
        portions: 42,
        preparing_time_minutes: 42,
        vegan: true,
        vegetarian: true
      })
      |> Reciper.Recipes.create_recipe()

    recipe
  end

  @doc """
  Generate a ingredient_quantity.
  """
  def ingredient_quantity_fixture(attrs \\ %{}) do
    {:ok, ingredient} =
      attrs
      |> Enum.into(%{
        category: :vegetable,
        name: "some name"
      })
      |> Reciper.Recipes.create_ingredient()

    {:ok, ingredient_quantity} =
      attrs
      |> Enum.into(%{
        measurement: :g,
        quantity: 42,
        ingredient_id: ingredient.id
      })
      |> Reciper.Recipes.create_ingredient_quantity()

    Repo.preload(ingredient_quantity, :ingredient)
  end
end
