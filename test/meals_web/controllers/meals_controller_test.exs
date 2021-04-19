defmodule MealsWeb.MealsControllerTest do
  use MealsWeb.ConnCase, async: true

  import Meals.Factory

  setup do
    id = "d9ab6dc9-543e-4b4d-ad4a-ba0a49b7cc08"

    {:ok, id: id}
  end

  describe "create/2" do
    test "when all params are valid, creates the meal", %{conn: conn} do
      params = build(:meal_api_params)

      response =
        conn
        |> post(Routes.meals_path(conn, :create, params))
        |> json_response(:created)

      expected_response = %{
        "meal" => %{
          "calorias" => 15,
          "data" => "2021-04-18T20:35:18.000000Z",
          "descricao" => "Paçoca"
        },
        "message" => "Meal created!"
      }

      assert response == expected_response
    end

    test "when there are invalid params, returns the errors", %{conn: conn} do
      params = build(:meal_api_params, %{"descricao" => "", "calorias" => 0})

      response =
        conn
        |> post(Routes.meals_path(conn, :create, params))
        |> json_response(:bad_request)

      expected_response = %{
        "message" => %{
          "calorias" => ["must be greater than %0"],
          "descricao" => ["can't be blank"]
        }
      }

      assert response == expected_response
    end
  end

  describe "show/2" do
    test "when the id is found, returns the meal", %{conn: conn, id: id} do
      insert(:meal, %{id: id})

      response =
        conn
        |> get(Routes.meals_path(conn, :show, id))
        |> json_response(:ok)

      expected_response = %{
        "meal" => %{
          "calorias" => 15,
          "data" => "2021-04-18T20:35:18.700086Z",
          "descricao" => "Paçoca"
        }
      }

      assert response == expected_response
    end

    test "when the id is not found, returns an error", %{conn: conn, id: id} do
      response =
        conn
        |> get(Routes.meals_path(conn, :show, id))
        |> json_response(:not_found)

      expected_response = %{"message" => "Meal not found!"}

      assert response == expected_response
    end
  end

  describe "update/2" do
    test "when the id is found and all params are valid, updates the meal", %{conn: conn, id: id} do
      insert(:meal, %{id: id})

      params = %{descricao: "Feijoada"}

      response =
        conn
        |> put(Routes.meals_path(conn, :update, id, params))
        |> json_response(:ok)

      expected_response = %{
        "meal" => %{
          "calorias" => 15,
          "data" => "2021-04-18T20:35:18.700086Z",
          "descricao" => "Feijoada"
        }
      }

      assert response == expected_response
    end

    test "when the id is not found, returns an error", %{conn: conn, id: id} do
      params = %{descricao: "Feijoada"}

      response =
        conn
        |> put(Routes.meals_path(conn, :update, id, params))
        |> json_response(:not_found)

      expected_response = %{"message" => "Meal not found!"}

      assert response == expected_response
    end

    test "when there are invalid params, returns the errors", %{conn: conn, id: id} do
      insert(:meal, %{id: id})

      params = %{descricao: "", calorias: 0}

      response =
        conn
        |> put(Routes.meals_path(conn, :update, id, params))
        |> json_response(:bad_request)

      expected_response = %{
        "message" => %{
          "calorias" => ["must be greater than %0"],
          "descricao" => ["can't be blank"]
        }
      }

      assert response == expected_response
    end
  end

  describe "delete/2" do
    test "when the id is found, deletes the meal", %{conn: conn, id: id} do
      insert(:meal, %{id: id})

      response =
        conn
        |> delete(Routes.meals_path(conn, :delete, id))
        |> response(:no_content)

      assert response == ""
    end

    test "when the id is not found, returns an error", %{conn: conn, id: id} do
      response =
        conn
        |> delete(Routes.meals_path(conn, :delete, id))
        |> json_response(:not_found)

      expected_response = %{"message" => "Meal not found!"}

      assert response == expected_response
    end
  end
end
