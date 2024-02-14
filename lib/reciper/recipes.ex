defmodule Reciper.Recipes do
  @moduledoc """
  The Recipes context.
  """

  import Ecto.Query, warn: false
  alias Reciper.Repo

  alias Reciper.Recipes.Ingredient

  @doc """
  Returns the list of ingredients.

  ## Examples

      iex> list_ingredients()
      [%Ingredient{}, ...]

  """
  def list_ingredients do
    Repo.all(Ingredient)
  end

  @doc """
  Gets a single ingredient.

  Raises `Ecto.NoResultsError` if the Ingredient does not exist.

  ## Examples

      iex> get_ingredient!(123)
      %Ingredient{}

      iex> get_ingredient!(456)
      ** (Ecto.NoResultsError)

  """
  def get_ingredient!(id), do: Repo.get!(Ingredient, id)

  @doc """
  Creates a ingredient.

  ## Examples

      iex> create_ingredient(%{field: value})
      {:ok, %Ingredient{}}

      iex> create_ingredient(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_ingredient(attrs \\ %{}) do
    %Ingredient{}
    |> Ingredient.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a ingredient.

  ## Examples

      iex> update_ingredient(ingredient, %{field: new_value})
      {:ok, %Ingredient{}}

      iex> update_ingredient(ingredient, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_ingredient(%Ingredient{} = ingredient, attrs) do
    ingredient
    |> Ingredient.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a ingredient.

  ## Examples

      iex> delete_ingredient(ingredient)
      {:ok, %Ingredient{}}

      iex> delete_ingredient(ingredient)
      {:error, %Ecto.Changeset{}}

  """
  def delete_ingredient(%Ingredient{} = ingredient) do
    Repo.delete(ingredient)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking ingredient changes.

  ## Examples

      iex> change_ingredient(ingredient)
      %Ecto.Changeset{data: %Ingredient{}}

  """
  def change_ingredient(%Ingredient{} = ingredient, attrs \\ %{}) do
    Ingredient.changeset(ingredient, attrs)
  end

  alias Reciper.Recipes.Recipe

  @doc """
  Returns the list of recipes.

  ## Examples

      iex> list_recipes()
      [%Recipe{}, ...]

  """
  def list_recipes do
    Repo.all(Recipe)
  end

  @doc """
  Gets a single recipe.

  Raises `Ecto.NoResultsError` if the Recipe does not exist.

  ## Examples

      iex> get_recipe!(123)
      %Recipe{}

      iex> get_recipe!(456)
      ** (Ecto.NoResultsError)

  """
  def get_recipe!(id), do: Repo.get!(Recipe, id)

  @doc """
  Creates a recipe.

  ## Examples

      iex> create_recipe(%{field: value})
      {:ok, %Recipe{}}

      iex> create_recipe(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_recipe(attrs \\ %{}) do
    %Recipe{}
    |> Recipe.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a recipe.

  ## Examples

      iex> update_recipe(recipe, %{field: new_value})
      {:ok, %Recipe{}}

      iex> update_recipe(recipe, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_recipe(%Recipe{} = recipe, attrs) do
    recipe
    |> Recipe.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a recipe.

  ## Examples

      iex> delete_recipe(recipe)
      {:ok, %Recipe{}}

      iex> delete_recipe(recipe)
      {:error, %Ecto.Changeset{}}

  """
  def delete_recipe(%Recipe{} = recipe) do
    Repo.delete(recipe)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking recipe changes.

  ## Examples

      iex> change_recipe(recipe)
      %Ecto.Changeset{data: %Recipe{}}

  """
  def change_recipe(%Recipe{} = recipe, attrs \\ %{}) do
    Recipe.changeset(recipe, attrs)
  end

  alias Reciper.Recipes.IngredientQuantity

  @doc """
  Returns the list of ingredient_quantities.

  ## Examples

      iex> list_ingredient_quantities()
      [%IngredientQuantity{}, ...]

  """
  def list_ingredient_quantities do
    Repo.all(IngredientQuantity) |> Repo.preload([:ingredient])
  end

  @doc """
  Gets a single ingredient_quantity.

  Raises `Ecto.NoResultsError` if the Ingredient quantity does not exist.

  ## Examples

      iex> get_ingredient_quantity!(123)
      %IngredientQuantity{}

      iex> get_ingredient_quantity!(456)
      ** (Ecto.NoResultsError)

  """
  def get_ingredient_quantity!(id),
    do: Repo.get!(IngredientQuantity, id) |> Repo.preload([:ingredient])

  @doc """
  Creates a ingredient_quantity.

  ## Examples

      iex> create_ingredient_quantity(%{field: value})
      {:ok, %IngredientQuantity{}}

      iex> create_ingredient_quantity(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_ingredient_quantity(attrs \\ %{}) do
    %IngredientQuantity{}
    |> IngredientQuantity.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a ingredient_quantity.

  ## Examples

      iex> update_ingredient_quantity(ingredient_quantity, %{field: new_value})
      {:ok, %IngredientQuantity{}}

      iex> update_ingredient_quantity(ingredient_quantity, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_ingredient_quantity(%IngredientQuantity{} = ingredient_quantity, attrs) do
    ingredient_quantity
    |> IngredientQuantity.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a ingredient_quantity.

  ## Examples

      iex> delete_ingredient_quantity(ingredient_quantity)
      {:ok, %IngredientQuantity{}}

      iex> delete_ingredient_quantity(ingredient_quantity)
      {:error, %Ecto.Changeset{}}

  """
  def delete_ingredient_quantity(%IngredientQuantity{} = ingredient_quantity) do
    Repo.delete(ingredient_quantity)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking ingredient_quantity changes.

  ## Examples

      iex> change_ingredient_quantity(ingredient_quantity)
      %Ecto.Changeset{data: %IngredientQuantity{}}

  """
  def change_ingredient_quantity(%IngredientQuantity{} = ingredient_quantity, attrs \\ %{}) do
    IngredientQuantity.update_changeset(ingredient_quantity, attrs)
  end
end
