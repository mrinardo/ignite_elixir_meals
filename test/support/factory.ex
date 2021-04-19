defmodule Meals.Factory do
  use ExMachina.Ecto, repo: Meals.Repo

  alias Meals.Meal

  def meal_params_factory do
    %{descricao: "Paçoca", calorias: 15, data: ~U[2021-04-18 20:35:18.700086Z]}
  end

  def meal_factory do
    %Meal{
      descricao: "Paçoca",
      calorias: 15,
      data: ~U[2021-04-18 20:35:18.700086Z],
      id: "df2547dd-c3f9-4b54-8099-8229bb75c900"
    }
  end

  def meal_api_params_factory do
    %{
      "descricao" => "Paçoca",
      "calorias" => 15,
      "data" => "2021-04-18 20:35:18"
    }
  end
end
