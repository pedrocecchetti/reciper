defmodule ReciperWeb.RecipeCreationLive do
  alias Reciper.Recipes
  use Phoenix.LiveView
  #
  import ReciperWeb.CoreComponents

  @measurement_units [{"g", :gramm}, {"l", :liter}]

  def render(assigns) do
    ~H"""
    <.simple_form phx-change="show" class="" key="2" for={%{}} phx-submit="save">
      <.input phx-change="show" name="recipe_name" value="SHOW" label="Recipe name"></.input>
      <.input name="recipe_time" type="number" value="" label="Recipe Time in Minutes"></.input>
      <.input name="recipe_portions" value="SHOW" label="Recipe Portions"></.input>

      <div class="w-6/12">
        <.input
          phx-change="search_ingredient"
          phx-debounce="200"
          name="ingredient_name"
          type="search"
          label="Ingredient search"
          value=""
        >
        </.input>
        <div id="result-box" class=" border border-black m-0 p-0 w-full">
          <%= for ingredient <- @ingredients do %>
            <ul>
              <li phx-click="select_ingredient" id={ingredient.name} value={ingredient.id}>
                <%= ingredient.name %> - <%= ingredient.category %>
              </li>
            </ul>
          <% end %>
        </div>
      </div>

      <.table id="users" rows={@selected_ingredients}>
        <:col :let={ingredient} label="Name">
          <.input value={ingredient.name} name={ingredient.name <> "show"} disabled>
            <%= ingredient.name %>
          </.input>
        </:col>
        <:col :let={ingredient} label="Category"><%= ingredient.category %></:col>
        <:col :let={ingredient} label="Quantity">
          <.input type="number" name={"ingredient-#{ingredient.id}-quantity"} value="0"></.input>
        </:col>

        <:col :let={ingredient} label="Unit">
          <.input
            type="select"
            name={"ingredient-#{ingredient.id}-measurement"}
            options={@measurement_units}
            value=""
          >
          </.input>
        </:col>
      </.table>
      <:actions>
        <.button>Submit</.button>
      </:actions>
    </.simple_form>
    """
  end

  def mount(_params, _session, socket) do
    ingredients = []
    selected_ingredients = []

    socket =
      socket
      |> assign(ingredients: ingredients)
      |> assign(selected_ingredients: selected_ingredients)
      |> assign(measurement_units: @measurement_units)

    {:ok, socket}
  end

  def handle_event(_event, %{"ingredient_name" => ingredient_name}, socket) do
    ingredients = Recipes.list_recipes_by_name(ingredient_name)
    {:noreply, assign(socket, :ingredients, ingredients)}
  end

  def handle_event("select_ingredient", %{"value" => ingredient_id}, socket) do
    ingredient = Recipes.get_ingredient!(ingredient_id)
    selected_ingredients = [ingredient | socket.assigns.selected_ingredients]
    socket = assign(socket, selected_ingredients: selected_ingredients)
    {:noreply, socket}
  end

  def handle_event("save", unsigned_params, socket) do
    IO.puts("SHHHOHOWHOHWOHWOHW")
    IO.inspect(unsigned_params)
    {:noreply, socket}
  end
end
