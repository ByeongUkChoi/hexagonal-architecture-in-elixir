defmodule Blog.Adapter.CommentRepo do
  alias Blog.Repo

  @behaviour Blog.ICommentRepo

  alias Blog.Domain.Comment, as: CommentDomain
  alias Blog.Adapter.Schemas.Comment, as: CommentSchema

  @impl true
  def insert(%CommentDomain{} = comment) do
    with {:ok, schema} <- CommentSchema.insert_changeset(comment) |> Repo.insert() do
      {:ok, CommentSchema.to_domain(schema)}
    end
  end
end
