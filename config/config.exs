# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :nfl_rush,
  ecto_repos: [NflRush.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :nfl_rush, NflRushWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "A3tvQYdTKb7ab2Rf9OFGAdVanhNLBj/WapVds08WfMoFqY9BxV62OMeLoTWLzHiA",
  render_errors: [view: NflRushWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: NflRush.PubSub,
  live_view: [signing_salt: "swFj9YMx"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
