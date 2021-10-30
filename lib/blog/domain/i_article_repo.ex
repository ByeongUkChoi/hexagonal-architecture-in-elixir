defmodule Blog.IArticleRepo do
  @callback insert(Blog.Article) :: {:ok, Blog.Article} | {:error, any()}
end
