ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(Blog.Repo, :manual)

# mock
Mox.defmock(Blog.MockArticleRepo, for: Blog.IArticleRepo)
Mox.defmock(Blog.MockCommentRepo, for: Blog.ICommentRepo)
