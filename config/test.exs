import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :blog, Blog.Repo,
  username: "postgres",
  password: "postgres",
  database: "blog_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :blog, BlogWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "AOKml5nP7ScbcSDuvATPAFUSkKVsaFiD8JtIsCm2OlX+VzeLSGsQymEVqypNvCQV",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

# dependency injection of adapters into ports
config :blog,
  article_repo: Blog.MockArticleRepo,
  article_like_repo: Blog.MockArticleLikeRepo,
  comment_repo: Blog.MockCommentRepo
