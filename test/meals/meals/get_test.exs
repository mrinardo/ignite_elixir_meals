defmodule Meals.Meals.GetTest do
  use Meals.DataCase, async: true

  import Meals.Factory

  alias Meals.{Error, Meal}
  alias Meals.Meals.Get

  describe "by_id/1" do
    test "when the id is found, returns the meal" do
      id = "df2547dd-c3f9-4b54-8099-8229bb75c900"

      insert(:meal, %{id: id})

      response = Get.by_id(id)

      assert {:ok, %Meal{}} = response
    end

    test "when the id is not found, returns an error" do
      id = "00000000-0000-0000-0000-000000000000"

      response = Get.by_id(id)

      assert {:error, %Error{status: :not_found, result: _result}} = response
    end
  end
end
