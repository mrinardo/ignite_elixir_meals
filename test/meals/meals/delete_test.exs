defmodule Meals.Meals.DeleteTest do
  use Meals.DataCase, async: true

  import Meals.Factory

  alias Meals.{Error, Meal}
  alias Meals.Meals.Delete

  describe "call/1" do
    test "when the id is found, deletes the meal" do
      id = "df2547dd-c3f9-4b54-8099-8229bb75c900"

      insert(:meal, %{id: id})

      response = Delete.call(id)

      assert {:ok, %Meal{}} = response
    end

    test "when the id is not found, returns an error" do
      id = "00000000-0000-0000-0000-000000000000"

      response = Delete.call(id)

      assert {:error, %Error{status: :not_found, result: _result}} = response
    end
  end
end
