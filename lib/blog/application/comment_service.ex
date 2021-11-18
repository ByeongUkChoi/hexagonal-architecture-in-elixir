defmodule Blog.CommentService do
  alias Blog.Domain.Comment

  @article_repo Application.get_env(:blog, :article_repo)

  def get_comments(article_id: article_id) do
    @comment_repo.get_all_by_article_id(article_id)
  end
end
