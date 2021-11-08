defmodule Blog.Adapter.Schemas.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  alias Blog.Domain.Comment, as: CommentDomain
  alias Blog.Adapter.Schemas.{User, Article}

  schema "comments" do
    field :content, :string
    belongs_to :writer, User
    belongs_to :article, Article

    timestamps()
  end

  def insert_changeset(%CommentDomain{} = comment_domain) do
    attrs = Map.from_struct(comment_domain)

    %__MODULE__{}
    |> cast(attrs, [:content, :writer_id, :article_id])
    |> validate_required([:content, :writer_id, :article_id])
    |> validate_number(:article_id, greater_than: 1)
    |> validate_number(:writer_id, greater_than: 1)
  end

  def to_domain(%__MODULE__{} = schema) do
    attrs =
      Map.from_struct(schema)
      |> Map.delete(:writer)
      |> Map.delete(:article)

    struct(%CommentDomain{}, attrs)
  end
end
