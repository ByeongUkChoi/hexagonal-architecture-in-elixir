defmodule Blog.IArticleRepo do
  alias Blog.Domain.Article

  @callback insert(Article.t()) :: {:ok, Article.t()} | {:error, any()}
end
