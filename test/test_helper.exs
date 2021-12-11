ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(Blog.Repo, :manual)

# mock
Mox.defmock(Blog.MockArticleRepo, for: Blog.Domain.IArticleRepo)
Mox.defmock(Blog.MockArticleLikeRepo, for: Blog.Domain.IArticleLikeRepo)
Mox.defmock(Blog.MockCommentRepo, for: Blog.Domain.ICommentRepo)
Mox.defmock(Blog.MockFollowerRepo, for: Blog.Domain.IFollowerRepo)
Mox.defmock(Blog.MockEmailSender, for: Blog.Application.IEmailSender)
Mox.defmock(Blog.MockNotificater, for: Blog.Application.INotificater)
