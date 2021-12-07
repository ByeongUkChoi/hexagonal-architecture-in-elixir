defmodule Blog.Article.Domain.IArticleRepo do
  alias Blog.Article.Domain.Article

  @callback get(Article.id()) :: {:ok, Article.t()} | {:error, any()}
  @callback get_paged(integer(), integer()) :: list(Article.t())
  @callback insert(Article.t()) :: {:ok, Article.t()} | {:error, any()}
  @callback update(Article.t()) :: {:ok, Article.t()} | {:error, any()}
end