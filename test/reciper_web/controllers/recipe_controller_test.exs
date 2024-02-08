defmodule ReciperWeb.RecipeControllerTest do
  use ReciperWeb.ConnCase

  import Reciper.RecipesFixtures

  @create_attrs %{name: "some name", preparing_time_minutes: 42, portions: 42, vegan: true, vegetarian: true, one_pot_recipe: true}
  @update_attrs %{name: "some updated name", preparing_time_minutes: 43, portions: 43, vegan: false, vegetarian: false, one_pot_recipe: false}
  @invalid_attrs %{name: nil, preparing_time_minutes: nil, portions: nil, vegan: nil, vegetarian: nil, one_pot_recipe: nil}

  describe "index" do
    test "lists all recipes", %{conn: conn} do
      conn = get(conn, ~p"/recipes")
      assert html_response(conn, 200) =~ "Listing Recipes"
    end
  end

  describe "new recipe" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/recipes/new")
      assert html_response(conn, 200) =~ "New Recipe"
    end
  end

  describe "create recipe" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/recipes", recipe: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/recipes/#{id}"

      conn = get(conn, ~p"/recipes/#{id}")
      assert html_response(conn, 200) =~ "Recipe #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/recipes", recipe: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Recipe"
    end
  end

  describe "edit recipe" do
    setup [:create_recipe]

    test "renders form for editing chosen recipe", %{conn: conn, recipe: recipe} do
      conn = get(conn, ~p"/recipes/#{recipe}/edit")
      assert html_response(conn, 200) =~ "Edit Recipe"
    end
  end

  describe "update recipe" do
    setup [:create_recipe]

    test "redirects when data is valid", %{conn: conn, recipe: recipe} do
      conn = put(conn, ~p"/recipes/#{recipe}", recipe: @update_attrs)
      assert redirected_to(conn) == ~p"/recipes/#{recipe}"

      conn = get(conn, ~p"/recipes/#{recipe}")
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, recipe: recipe} do
      conn = put(conn, ~p"/recipes/#{recipe}", recipe: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Recipe"
    end
  end

  describe "delete recipe" do
    setup [:create_recipe]

    test "deletes chosen recipe", %{conn: conn, recipe: recipe} do
      conn = delete(conn, ~p"/recipes/#{recipe}")
      assert redirected_to(conn) == ~p"/recipes"

      assert_error_sent 404, fn ->
        get(conn, ~p"/recipes/#{recipe}")
      end
    end
  end

  defp create_recipe(_) do
    recipe = recipe_fixture()
    %{recipe: recipe}
  end
end
