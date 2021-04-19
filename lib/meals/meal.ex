defmodule Meals.Meal do
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  @required_fields [:descricao, :data, :calorias]

  @derive {Jason.Encoder, only: @required_fields}

  schema "meals" do
    field :descricao, :string
    field :data, :utc_datetime_usec
    field(:calorias, :integer)

    timestamps()
  end

  def changeset(params) do
    {:ok, now} = DateTime.now("Etc/UTC")

    %__MODULE__{}
    |> change(data: now)
    |> create_changeset(params)
  end

  def changeset(struct, params) do
    struct
    |> create_changeset(params)
  end

  defp create_changeset(struct, params) do
    struct
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
    |> validate_number(:calorias, greater_than: 0)
    |> validate_change(:data, &cannot_be_future_date/2)
  end

  defp cannot_be_future_date(:data, data) do
    {:ok, now} = DateTime.now("Etc/UTC")

    case Date.compare(DateTime.to_date(data), DateTime.to_date(now)) do
      :gt -> [data: "Date cannot be in the future."]
      _ -> []
    end
  end
end
