defmodule Meals.Meals.UpdateTest do
  use Meals.DataCase, async: true

  import Meals.Factory

  alias Meals.{Error, Meal}
  alias Meals.Meals.Update

  describe "call/1" do
    test "when all params are valid, update the meal" do
      id = "df2547dd-c3f9-4b54-8099-8229bb75c900"
      params = %{"id" => id, "descricao" => "Feijoada"}

      insert(:meal, %{id: id})

      response = Update.call(params)

      assert {:ok, %Meal{descricao: "Feijoada"}} = response
    end

    test "when there are invalid params, returns errors" do
      id = "df2547dd-c3f9-4b54-8099-8229bb75c900"
      params = %{"id" => id, "descricao" => "", "calorias" => 0}

      insert(:meal, %{id: id})

      response = Update.call(params)

      expected_response = %{calorias: ["must be greater than 0"], descricao: ["can't be blank"]}

      assert {:error, %Error{status: :bad_request, result: changeset}} = response
      assert errors_on(changeset) == expected_response
    end

    test "when the id is not found, returns an error" do
      id = "00000000-0000-0000-0000-000000000000"
      params = %{"id" => id, "calorias" => 100}

      response = Update.call(params)

      assert {:error, %Error{status: :not_found, result: _result}} = response
    end
  end
end
