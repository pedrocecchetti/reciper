defmodule ReciperWeb.IngredientQuantityController do
  use ReciperWeb, :controller

  alias Reciper.Recipes
  alias Reciper.Recipes.IngredientQuantity

  def index(conn, _params) do
    ingredient_quantities = Recipes.list_ingredient_quantities()
    render(conn, :index, ingredient_quantities: ingredient_quantities)
  end

  def new(conn, _params) do
    changeset = Recipes.change_ingredient_quantity(%IngredientQuantity{})
    ingredients = Recipes.list_ingredients()

    conn
    |> assign(:ingredients, ingredients)
    |> render(:new, changeset: changeset)
  end

  def create(conn, %{"ingredient_quantity" => ingredient_quantity_params}) do
    case Recipes.create_ingredient_quantity(ingredient_quantity_params) do
      {:ok, ingredient_quantity} ->
        conn
        |> put_flash(:info, "Ingredient quantity created successfully.")
        |> redirect(to: ~p"/ingredient_quantities/#{ingredient_quantity}")

      {:error, %Ecto.Changeset{} = changeset} ->
        ingredients = Recipes.list_ingredients()
        render(conn, :new, changeset: changeset, ingredients: ingredients)
    end
  end

  def show(conn, %{"id" => id}) do
    ingredient_quantity = Recipes.get_ingredient_quantity!(id)
    render(conn, :show, ingredient_quantity: ingredient_quantity)
  end

  def edit(conn, %{"id" => id}) do
    ingredient_quantity = Recipes.get_ingredient_quantity!(id)
    changeset = Recipes.change_ingredient_quantity(ingredient_quantity)
    render(conn, :edit, ingredient_quantity: ingredient_quantity, changeset: changeset)
  end

  def update(conn, %{"id" => id, "ingredient_quantity" => ingredient_quantity_params}) do
    ingredient_quantity = Recipes.get_ingredient_quantity!(id)

    case Recipes.update_ingredient_quantity(ingredient_quantity, ingredient_quantity_params) do
      {:ok, ingredient_quantity} ->
        conn
        |> put_flash(:info, "Ingredient quantity updated successfully.")
        |> redirect(to: ~p"/ingredient_quantities/#{ingredient_quantity}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, ingredient_quantity: ingredient_quantity, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    ingredient_quantity = Recipes.get_ingredient_quantity!(id)
    {:ok, _ingredient_quantity} = Recipes.delete_ingredient_quantity(ingredient_quantity)

    conn
    |> put_flash(:info, "Ingredient quantity deleted successfully.")
    |> redirect(to: ~p"/ingredient_quantities")
  end
end
