defmodule Blog.IArticleLikeRepo do
  alias Blog.Domain.{Article, ArticleLike}

  @callback like(Article.id(), integer()) :: {:ok, ArticleLike.t()} | {:error, any()}
end
