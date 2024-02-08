defmodule ReciperWeb.IngredientController do
  use ReciperWeb, :controller

  alias Reciper.Recipes
  alias Reciper.Recipes.Ingredient

  def index(conn, _params) do
    ingredients = Recipes.list_ingredients()
    render(conn, :index, ingredients: ingredients)
  end

  def new(conn, _params) do
    changeset = Recipes.change_ingredient(%Ingredient{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"ingredient" => ingredient_params}) do
    case Recipes.create_ingredient(ingredient_params) do
      {:ok, ingredient} ->
        conn
        |> put_flash(:info, "Ingredient created successfully.")
        |> redirect(to: ~p"/ingredients/#{ingredient}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    ingredient = Recipes.get_ingredient!(id)
    render(conn, :show, ingredient: ingredient)
  end

  def edit(conn, %{"id" => id}) do
    ingredient = Recipes.get_ingredient!(id)
    changeset = Recipes.change_ingredient(ingredient)
    render(conn, :edit, ingredient: ingredient, changeset: changeset)
  end

  def update(conn, %{"id" => id, "ingredient" => ingredient_params}) do
    ingredient = Recipes.get_ingredient!(id)

    case Recipes.update_ingredient(ingredient, ingredient_params) do
      {:ok, ingredient} ->
        conn
        |> put_flash(:info, "Ingredient updated successfully.")
        |> redirect(to: ~p"/ingredients/#{ingredient}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, ingredient: ingredient, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    ingredient = Recipes.get_ingredient!(id)
    {:ok, _ingredient} = Recipes.delete_ingredient(ingredient)

    conn
    |> put_flash(:info, "Ingredient deleted successfully.")
    |> redirect(to: ~p"/ingredients")
  end
end
