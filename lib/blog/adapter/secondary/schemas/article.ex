defmodule Blog.Adapter.Schemas.Article do
  use Ecto.Schema
  import Ecto.Changeset

  alias Blog.Adapter.Schemas.{User, Comment}

  schema "articles" do
    field :title, :string
    field :content, :string
    belongs_to :writer, User
    has_many :comments, Comment

    timestamps()
  end

  def insert_changeset(%Blog.Domain.Article{} = article) do
    attrs = Map.from_struct(article)

    %__MODULE__{}
    |> cast(attrs, [:title, :content, :writer_id])
    |> validate_required([:title, :content, :writer_id])
  end

  def to_domain(%__MODULE__{} = schema) do
    attrs =
      Map.from_struct(schema)
      |> Map.delete(:writer)
      |> Map.delete(:comments)

    struct(%Blog.Domain.Article{}, attrs)
  end
end
