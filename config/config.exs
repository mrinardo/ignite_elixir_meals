# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :meals,
  ecto_repos: [Meals.Repo]

config :meals, Meals.Repo,
  migration_primary_key: [type: :binary_id],
  migration_foreign_key: [type: :binary_id]

# Configures the endpoint
config :meals, MealsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "A4Ub1dpuHtngTRJp7jEm2N8Zw3bJ+SXmxI1MKAzGufB1KANQyoXmHb8xE+1WmaRh",
  render_errors: [view: MealsWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Meals.PubSub,
  live_view: [signing_salt: "C1PYU2EI"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
