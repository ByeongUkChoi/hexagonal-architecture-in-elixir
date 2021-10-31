defmodule Blog.Adapter.ArticleRepo do
  alias Blog.Repo

  @behaviour Blog.IArticleRepo

  alias Blog.Adapter.Schemas.Article

  @impl true
  def insert(%Blog.Domain.Article{} = article) do
    with {:ok, schema} <- Article.insert_changeset(article) |> Repo.insert() do
      {:ok, Article.to_domain(schema)}
    end
  end
end
