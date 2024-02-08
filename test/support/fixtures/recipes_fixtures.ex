defmodule Reciper.RecipesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Reciper.Recipes` context.
  """

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
end
