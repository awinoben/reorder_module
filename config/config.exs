# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :reorder_module,
  ecto_repos: [ReorderModule.Repo]

# Configures the endpoint
config :reorder_module, ReorderModuleWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "LPh/ts2b2GVX2yu5kYIoJHeu5o+CyLSio+HD08/7uXklTXmxIn36fjfM3fpGapZQ",
  render_errors: [view: ReorderModuleWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: ReorderModule.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
