# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :blog,
  ecto_repos: [Blog.Repo]

# Configures the endpoint
config :blog, BlogWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: BlogWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Blog.PubSub,
  live_view: [signing_salt: "y5w6SGVk"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# dependency injection of adapters into ports
config :blog,
  article_repo: Blog.Adapter.ArticleRepo,
  article_like_repo: Blog.Adapter.ArticleLikeRepo,
  comment_repo: Blog.Adapter.CommentRepo,
  notificater: Blog.Application.Notificater

# follower_repo: Blog.Adapter.FollowerRe
# email_sender: Blog.Adapter.EmailSender

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
