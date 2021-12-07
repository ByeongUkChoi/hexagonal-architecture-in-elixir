defmodule Blog.Adapter.Schemas.Article do
  use Ecto.Schema
  import Ecto.Changeset

  alias Blog.Domain.Article, as: ArticleDomain
  alias Blog.Adapter.Schemas.{User, Comment}

  schema "articles" do
    field :title, :string
    field :content, :string
    belongs_to :writer, User
    has_many :comments, Comment
    field :deleted_at, :naive_datetime

    timestamps()
  end

  def insert_changeset(%ArticleDomain{} = article_domain) do
    attrs = Map.from_struct(article_domain)

    %__MODULE__{}
    |> cast(attrs, [:title, :content, :writer_id])
    |> validate_required([:title, :content, :writer_id])
  end

  def update_changeset(schema, %ArticleDomain{} = article_domain) do
    attrs = Map.from_struct(article_domain)

    schema
    |> cast(attrs, [:title, :content])
    |> validate_required([:title, :content])
  end

  def to_domain(%__MODULE__{} = schema) do
    attrs =
      Map.from_struct(schema)
      |> Map.delete(:writer)
      |> Map.delete(:comments)

    struct(%ArticleDomain{}, attrs)
  end
end
