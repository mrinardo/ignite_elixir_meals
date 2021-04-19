defmodule Meals.MealTest do
  use Meals.DataCase, async: true

  import Meals.Factory

  alias Ecto.Changeset
  alias Meals.Meal

  describe "changeset/1" do
    test "when all params are valid, returns a changeset for new meal entry" do
      params = build(:meal_params)

      response = Meal.changeset(params)

      assert %Changeset{changes: %{descricao: "Paçoca"}, valid?: true} = response
    end

    test "when there are invalid params, returns errors" do
      params = build(:meal_params, %{calorias: 0, descricao: ""})

      response = Meal.changeset(params)

      expected_response = %{calorias: ["must be greater than 0"], descricao: ["can't be blank"]}

      assert errors_on(response) == expected_response
    end
  end

  describe "changeset/2" do
    test "when all params are valid, returns a changeset for the updated meal entry" do
      params = build(:meal_params)
      params_update = %{calorias: 20}

      response =
        params
        |> Meal.changeset()
        |> Meal.changeset(params_update)

      assert %Changeset{changes: %{calorias: 20}, valid?: true} = response
    end

    test "when there are invalid params, returns errors" do
      params = build(:meal_params)
      params_update = %{calorias: 0}

      response =
        params
        |> Meal.changeset()
        |> Meal.changeset(params_update)

      expected_response = %{calorias: ["must be greater than 0"]}

      assert errors_on(response) == expected_response
    end
  end
end
