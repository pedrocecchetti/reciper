defmodule Reciper.RecipesTest do
  use Reciper.DataCase

  alias Reciper.Recipes

  describe "ingredients" do
    alias Reciper.Recipes.Ingredient

    import Reciper.RecipesFixtures

    @invalid_attrs %{name: nil, category: nil}

    test "list_ingredients/0 returns all ingredients" do
      ingredient = ingredient_fixture()
      assert Recipes.list_ingredients() == [ingredient]
    end

    test "get_ingredient!/1 returns the ingredient with given id" do
      ingredient = ingredient_fixture()
      assert Recipes.get_ingredient!(ingredient.id) == ingredient
    end

    test "create_ingredient/1 with valid data creates a ingredient" do
      valid_attrs = %{name: "some name", category: :vegetable}

      assert {:ok, %Ingredient{} = ingredient} = Recipes.create_ingredient(valid_attrs)
      assert ingredient.name == "some name"
      assert ingredient.category == :vegetable
    end

    test "create_ingredient/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Recipes.create_ingredient(@invalid_attrs)
    end

    test "update_ingredient/2 with valid data updates the ingredient" do
      ingredient = ingredient_fixture()
      update_attrs = %{name: "some updated name", category: :dairy}

      assert {:ok, %Ingredient{} = ingredient} = Recipes.update_ingredient(ingredient, update_attrs)
      assert ingredient.name == "some updated name"
      assert ingredient.category == :dairy
    end

    test "update_ingredient/2 with invalid data returns error changeset" do
      ingredient = ingredient_fixture()
      assert {:error, %Ecto.Changeset{}} = Recipes.update_ingredient(ingredient, @invalid_attrs)
      assert ingredient == Recipes.get_ingredient!(ingredient.id)
    end

    test "delete_ingredient/1 deletes the ingredient" do
      ingredient = ingredient_fixture()
      assert {:ok, %Ingredient{}} = Recipes.delete_ingredient(ingredient)
      assert_raise Ecto.NoResultsError, fn -> Recipes.get_ingredient!(ingredient.id) end
    end

    test "change_ingredient/1 returns a ingredient changeset" do
      ingredient = ingredient_fixture()
      assert %Ecto.Changeset{} = Recipes.change_ingredient(ingredient)
    end
  end

  describe "recipes" do
    alias Reciper.Recipes.Recipe

    import Reciper.RecipesFixtures

    @invalid_attrs %{name: nil, preparing_time_minutes: nil, portions: nil, vegan: nil, vegetarian: nil, one_pot_recipe: nil}

    test "list_recipes/0 returns all recipes" do
      recipe = recipe_fixture()
      assert Recipes.list_recipes() == [recipe]
    end

    test "get_recipe!/1 returns the recipe with given id" do
      recipe = recipe_fixture()
      assert Recipes.get_recipe!(recipe.id) == recipe
    end

    test "create_recipe/1 with valid data creates a recipe" do
      valid_attrs = %{name: "some name", preparing_time_minutes: 42, portions: 42, vegan: true, vegetarian: true, one_pot_recipe: true}

      assert {:ok, %Recipe{} = recipe} = Recipes.create_recipe(valid_attrs)
      assert recipe.name == "some name"
      assert recipe.preparing_time_minutes == 42
      assert recipe.portions == 42
      assert recipe.vegan == true
      assert recipe.vegetarian == true
      assert recipe.one_pot_recipe == true
    end

    test "create_recipe/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Recipes.create_recipe(@invalid_attrs)
    end

    test "update_recipe/2 with valid data updates the recipe" do
      recipe = recipe_fixture()
      update_attrs = %{name: "some updated name", preparing_time_minutes: 43, portions: 43, vegan: false, vegetarian: false, one_pot_recipe: false}

      assert {:ok, %Recipe{} = recipe} = Recipes.update_recipe(recipe, update_attrs)
      assert recipe.name == "some updated name"
      assert recipe.preparing_time_minutes == 43
      assert recipe.portions == 43
      assert recipe.vegan == false
      assert recipe.vegetarian == false
      assert recipe.one_pot_recipe == false
    end

    test "update_recipe/2 with invalid data returns error changeset" do
      recipe = recipe_fixture()
      assert {:error, %Ecto.Changeset{}} = Recipes.update_recipe(recipe, @invalid_attrs)
      assert recipe == Recipes.get_recipe!(recipe.id)
    end

    test "delete_recipe/1 deletes the recipe" do
      recipe = recipe_fixture()
      assert {:ok, %Recipe{}} = Recipes.delete_recipe(recipe)
      assert_raise Ecto.NoResultsError, fn -> Recipes.get_recipe!(recipe.id) end
    end

    test "change_recipe/1 returns a recipe changeset" do
      recipe = recipe_fixture()
      assert %Ecto.Changeset{} = Recipes.change_recipe(recipe)
    end
  end
end
