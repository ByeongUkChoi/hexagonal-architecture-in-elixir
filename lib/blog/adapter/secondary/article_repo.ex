defmodule Blog.Adapter.ArticleRepo do
  alias Blog.Repo

  @behaviour Blog.IArticleRepo

  alias Blog.Domain.Article, as: ArticleDomain
  alias Blog.Adapter.Schemas.Article, as: ArticleSchema

  @impl true
  def insert(%ArticleDomain{} = article) do
    with {:ok, schema} <- ArticleSchema.insert_changeset(article) |> Repo.insert() do
      {:ok, ArticleSchema.to_domain(schema)}
    end
  end

  @impl true
  def update(%ArticleDomain{id: article_id} = article) do
    with %ArticleSchema{} = schema <- Repo.get(ArticleSchema, article_id),
         {:ok, schema} <- ArticleSchema.update_changeset(schema, article) |> Repo.update() do
      {:ok, ArticleSchema.to_domain(schema)}
    end
  end
end
