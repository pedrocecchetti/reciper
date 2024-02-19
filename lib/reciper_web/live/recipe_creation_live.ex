defmodule ReciperWeb.RecipeCreationLive do
  alias Reciper.Recipes
  use Phoenix.LiveView
  #
  import ReciperWeb.CoreComponents

  def render(assigns) do
    ~H"""
    <.simple_form phx-change="show" class="" key="2" for={%{}}>
      <.input phx-change="show" name="recipe_name" value="SHOW" label="Recipe name"></.input>
      <.input name="recipe_time" type="number" value="" label="Recipe Time in Minutes"></.input>
      <.input name="recipe_portions" value="SHOW" label="Recipe Portions"></.input>

      <.input
        phx-change="search_ingredient"
        name="ingredient_name"
        type="search"
        label="Ingredient search"
        value=""
      >
      </.input>

      <div>
        <%= for ingredient <- @ingredients do %>
          <h1>
            <%= ingredient.name %>
          </h1>
          <h2><%= ingredient.category %></h2>
        <% end %>
      </div>
    </.simple_form>
    """
  end

  def mount(_params, _session, socket) do
    ingredients = []
    {:ok, assign(socket, ingredients: ingredients)}
  end

  def handle_event("show", unsigned_params, socket) do
    IO.inspect(unsigned_params)
    {:noreply, socket}
  end

  def handle_event(_event, %{"ingredient_name" => ingredient_name}, socket) do
    ingredients = Recipes.list_recipes_ny_name(ingredient_name)
    IO.inspect(ingredients)
    {:noreply, assign(socket, :ingredients, ingredients)}
  end
end
