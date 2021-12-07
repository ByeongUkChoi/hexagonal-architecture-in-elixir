defmodule Blog.Article.Domain.ICommentRepo do
  alias Blog.Article.Domain.{Article, Comment}

  @callback insert(Comment.t()) :: {:ok, Comment.t()} | {:error, any()}
  @callback get_all_by_article_id(Article.id()) :: list(Comment.t()) | {:error, any()}
end
