defmodule MealsWeb.MealsViewTest do
  use MealsWeb.ConnCase, async: true

  import Phoenix.View
  import Meals.Factory

  alias Meals.Meal
  alias MealsWeb.MealsView

  test "renders create.json" do
    meal = build(:meal)

    response = render(MealsView, "create.json", meal: meal)

    assert response == %{
             meal: %Meal{
               calorias: 15,
               data: ~U[2021-04-18 20:35:18.700086Z],
               descricao: "Paçoca",
               id: "df2547dd-c3f9-4b54-8099-8229bb75c900",
               inserted_at: nil,
               updated_at: nil
             },
             message: "Meal created!"
           }
  end
end
