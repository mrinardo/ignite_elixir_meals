defmodule Meals.Repo do
  use Ecto.Repo,
    otp_app: :meals,
    adapter: Ecto.Adapters.Postgres
end
