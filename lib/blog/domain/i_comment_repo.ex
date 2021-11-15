defmodule Blog.ICommentRepo do
  alias Blog.Domain.{Article, Comment}

  @callback insert(Comment.t()) :: {:ok, Comment.t()} | {:error, any()}
  @callback get_all_by_article_id(Article.id()) :: list(Comment.t()) | {:error, any()}
end
