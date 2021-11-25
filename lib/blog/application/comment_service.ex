defmodule Blog.Application.CommentService do
  alias Blog.Domain.Comment

  @article_repo Application.get_env(:blog, :article_repo)
  @comment_repo Application.get_env(:blog, :comment_repo)

  def get_comments(article_id: article_id) do
    @comment_repo.get_all_by_article_id(article_id)
  end

  def create_comment([content: _, article_id: article_id, writer_id: _] = attr) do
    with {:ok, _article_domain} <- @article_repo.get(article_id),
         {:ok, comment} <- Comment.new(attr),
         {:ok, comment} <- @comment_repo.insert(comment) do
      {:ok, comment}
    end
  end
end
