defmodule Meals.Repo.Migrations.CreateMealsTable do
  use Ecto.Migration

  def change do
    create table :meals do
      add :descricao, :string
      add :data, :utc_datetime_usec
      add :calorias, :integer

      timestamps()
    end

  end
end
