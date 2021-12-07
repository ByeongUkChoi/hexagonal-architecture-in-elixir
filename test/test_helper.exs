ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(Blog.Repo, :manual)

# mock
Mox.defmock(Blog.MockArticleRepo, for: Blog.Article.Domain.IArticleRepo)
Mox.defmock(Blog.MockArticleLikeRepo, for: Blog.Article.Domain.IArticleLikeRepo)
Mox.defmock(Blog.MockCommentRepo, for: Blog.Article.Domain.ICommentRepo)
