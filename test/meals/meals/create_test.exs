defmodule Meals.Meals.CreateTest do
  use Meals.DataCase, async: true

  import Meals.Factory

  alias Meals.{Error, Meal}
  alias Meals.Meals.Create

  describe "call/1" do
    test "when all params are valid, creates a new meal" do
      params = build(:meal_params)

      response = Create.call(params)

      assert {:ok, %Meal{descricao: "Paçoca", id: _id, calorias: 15}} = response
    end

    test "when there are invalid params, returns an error" do
      params =
        build(:meal_params, %{
          calorias: 0,
          data: DateTime.add(DateTime.now!("Etc/UTC"), 10 * 24 * 60 * 60, :second)
        })

      response = Create.call(params)

      expected_response = %{
        calorias: ["must be greater than 0"],
        data: ["Date cannot be in the future."]
      }

      assert {:error, %Error{status: :bad_request, result: changeset}} = response
      assert errors_on(changeset) == expected_response
    end
  end
end
