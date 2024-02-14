defmodule ReciperWeb.IngredientQuantityControllerTest do
  use ReciperWeb.ConnCase

  import Reciper.RecipesFixtures

  @create_attrs %{measurement: :g, quantity: 42}
  @update_attrs %{measurement: :kg, quantity: 43}
  @invalid_attrs %{measurement: nil, quantity: nil}

  describe "index" do
    test "lists all ingredient_quantities", %{conn: conn} do
      conn = get(conn, ~p"/ingredient_quantities")
      assert html_response(conn, 200) =~ "Listing Ingredient quantities"
    end
  end

  describe "new ingredient_quantity" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/ingredient_quantities/new")
      assert html_response(conn, 200) =~ "New Ingredient quantity"
    end
  end

  describe "create ingredient_quantity" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/ingredient_quantities", ingredient_quantity: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/ingredient_quantities/#{id}"

      conn = get(conn, ~p"/ingredient_quantities/#{id}")
      assert html_response(conn, 200) =~ "Ingredient quantity #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/ingredient_quantities", ingredient_quantity: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Ingredient quantity"
    end
  end

  describe "edit ingredient_quantity" do
    setup [:create_ingredient_quantity]

    test "renders form for editing chosen ingredient_quantity", %{conn: conn, ingredient_quantity: ingredient_quantity} do
      conn = get(conn, ~p"/ingredient_quantities/#{ingredient_quantity}/edit")
      assert html_response(conn, 200) =~ "Edit Ingredient quantity"
    end
  end

  describe "update ingredient_quantity" do
    setup [:create_ingredient_quantity]

    test "redirects when data is valid", %{conn: conn, ingredient_quantity: ingredient_quantity} do
      conn = put(conn, ~p"/ingredient_quantities/#{ingredient_quantity}", ingredient_quantity: @update_attrs)
      assert redirected_to(conn) == ~p"/ingredient_quantities/#{ingredient_quantity}"

      conn = get(conn, ~p"/ingredient_quantities/#{ingredient_quantity}")
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, ingredient_quantity: ingredient_quantity} do
      conn = put(conn, ~p"/ingredient_quantities/#{ingredient_quantity}", ingredient_quantity: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Ingredient quantity"
    end
  end

  describe "delete ingredient_quantity" do
    setup [:create_ingredient_quantity]

    test "deletes chosen ingredient_quantity", %{conn: conn, ingredient_quantity: ingredient_quantity} do
      conn = delete(conn, ~p"/ingredient_quantities/#{ingredient_quantity}")
      assert redirected_to(conn) == ~p"/ingredient_quantities"

      assert_error_sent 404, fn ->
        get(conn, ~p"/ingredient_quantities/#{ingredient_quantity}")
      end
    end
  end

  defp create_ingredient_quantity(_) do
    ingredient_quantity = ingredient_quantity_fixture()
    %{ingredient_quantity: ingredient_quantity}
  end
end
