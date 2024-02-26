defmodule ReciperWeb.RecipeCreationLive do
  alias Reciper.Recipes
  use Phoenix.LiveView
  #
  import ReciperWeb.CoreComponents

  @measurement_units [{"g", :gramm}, {"l", :liter}]

  def render(assigns) do
    ~H"""
    <.flash_group flash={@flash} />
    <.simple_form class="w-5/12 items-center m-auto" key="new_recipe" for={@form} phx-submit="save">
      <.input name="recipe_name" value="" label="Recipe name"></.input>
      <.input name="recipe_time" type="number" value="" label="Execution Time in Minutes"></.input>
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
          <.input type="number" name={"ingredient_#{ingredient.id}_quantity"} value="0"></.input>
        </:col>

        <:col :let={ingredient}>
          <.input
            type="select"
            name={"ingredient_#{ingredient.id}_measurement"}
            options={@measurement_units}
            value=""
          >
          </.input>
        </:col>
        <:col :let={ingredient} label="Unit">
          <.button phx-click="delete-row" value={ingredient.id}>
            <.icon name="hero-trash-solid" />
          </.button>
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
      |> assign(:form, %{})
      |> put_flash(
        :info,
        "Please add all ingredients before changing the quantities and measurement units"
      )

    {:ok, socket}
  end

  def handle_event("search_ingredient", %{"ingredient_name" => ingredient_name}, socket) do
    ingredients = Recipes.list_recipes_by_name(ingredient_name)
    {:noreply, assign(socket, :ingredients, ingredients)}
  end

  def handle_event("select_ingredient", %{"value" => ingredient_id}, socket) do
    ingredient = Recipes.get_ingredient!(ingredient_id)

    selected_igredients =
      if Enum.member?(socket.assigns.selected_ingredients, ingredient) do
        socket.assigns.selected_ingredients
      else
        [ingredient | socket.assigns.selected_ingredients]
      end

    socket = assign(socket, selected_ingredients: selected_igredients)
    {:noreply, socket}
  end

  def handle_event("delete-row", %{"value" => value}, socket) do
    selected_ingredients =
      Enum.filter(socket.assigns.selected_ingredients, fn ingredient ->
        ingredient.id != String.to_integer(value)
      end)

    socket = assign(socket, :selected_ingredients, selected_ingredients)
    {:noreply, socket}
  end

  def handle_event("save", unsigned_params, socket) do
    IO.inspect(unsigned_params)
    {:noreply, socket}
  end
end
