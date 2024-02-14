defmodule ReciperWeb.IngredientQuantityHTML do
  use ReciperWeb, :html

  embed_templates "ingredient_quantity_html/*"

  @doc """
  Renders a ingredient_quantity form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def ingredient_quantity_form(assigns)
end
