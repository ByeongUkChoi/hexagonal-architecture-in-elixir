defmodule Blog.IArticleRepo do
  alias Blog.Domain.Article

  @callback insert(Article) :: {:ok, Article} | {:error, any()}
end
