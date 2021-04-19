defmodule Meals do
  alias Meals.Meals.Create, as: MealCreate
  alias Meals.Meals.Delete, as: MealDelete
  alias Meals.Meals.Get, as: MealGet
  alias Meals.Meals.Update, as: MealUpdate

  defdelegate create_meal(params), to: MealCreate, as: :call
  defdelegate get_meal_by_id(id), to: MealGet, as: :by_id
  defdelegate update_meal(id), to: MealUpdate, as: :call
  defdelegate delete_meal(id), to: MealDelete, as: :call
end
