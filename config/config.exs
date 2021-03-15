# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :harmony_live,
  ecto_repos: [HarmonyLive.Repo]

# Configures the endpoint
config :harmony_live, HarmonyLiveWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "pAWJjRp94qx4Jr1PDBB3guSLuH3bkjf0lLWlWeJ3PU34l9LKX4hAXUu8g9k6WU+5",
  render_errors: [view: HarmonyLiveWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: HarmonyLive.PubSub,
  live_view: [signing_salt: "uPWQk5qd"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
