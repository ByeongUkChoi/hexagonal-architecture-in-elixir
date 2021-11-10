defmodule Blog.IArticleRepo do
  alias Blog.Domain.Article

  @callback get(Article.id()) :: {:ok, Article.t()} | {:error, any()}
  @callback insert(Article.t()) :: {:ok, Article.t()} | {:error, any()}
  @callback update(Article.t()) :: {:ok, Article.t()} | {:error, any()}
end
