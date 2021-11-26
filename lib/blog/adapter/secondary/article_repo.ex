defmodule Blog.Adapter.ArticleRepo do
  @behaviour Blog.IArticleRepo

  import Ecto.Query

  alias Blog.Repo

  alias Blog.Domain.Article, as: ArticleDomain
  alias Blog.Adapter.Schemas.Article, as: ArticleSchema

  @impl true
  def get(article_id) do
    case Repo.get(ArticleSchema, article_id) do
      %ArticleSchema{} = article_schema -> {:ok, article_schema}
      _ -> {:error, :not_found_article}
    end
  end

  @impl true
  def get_paged(page, size) do
    ArticleSchema
    |> limit(^size)
    |> offset(^(page * size))
    |> Repo.all()
    |> Enum.map(&ArticleSchema.to_domain/1)
  end

  @impl true
  def insert(%ArticleDomain{} = article) do
    with {:ok, schema} <- ArticleSchema.insert_changeset(article) |> Repo.insert() do
      {:ok, ArticleSchema.to_domain(schema)}
    end
  end

  @impl true
  def update(%ArticleDomain{id: article_id} = article) do
    with {:ok, schema} <- get(article_id),
         {:ok, schema} <- ArticleSchema.update_changeset(schema, article) |> Repo.update() do
      {:ok, ArticleSchema.to_domain(schema)}
    end
  end
end
