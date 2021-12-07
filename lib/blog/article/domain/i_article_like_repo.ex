defmodule Blog.Article.Domain.IArticleLikeRepo do
  alias Blog.Article.Domain.{Article, ArticleLike}

  @callback like(Article.id(), integer()) :: {:ok, ArticleLike.t()} | {:error, any()}
end
