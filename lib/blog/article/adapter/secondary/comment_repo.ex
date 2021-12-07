defmodule Blog.Article.Adapter.CommentRepo do
  @behaviour Blog.Article.Domain.ICommentRepo

  import Ecto.Query

  alias Blog.Repo
  alias Blog.Article.Domain.Comment, as: CommentDomain
  alias Blog.Article.Adapter.Schemas.Comment, as: CommentSchema

  @impl true
  def insert(%CommentDomain{} = comment) do
    with {:ok, schema} <- CommentSchema.insert_changeset(comment) |> Repo.insert() do
      {:ok, CommentSchema.to_domain(schema)}
    end
  end

  @impl true
  def get_all_by_article_id(article_id) do
    CommentSchema
    |> where([c], c.article_id == ^article_id)
    |> Repo.all()
    |> Enum.map(&CommentSchema.to_domain(&1))
  end
end
