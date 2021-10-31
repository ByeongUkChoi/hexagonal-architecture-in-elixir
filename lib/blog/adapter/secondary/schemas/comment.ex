defmodule Blog.Adapter.Schemas.Comment do
  use Ecto.Schema
  # import Ecto.Changeset

  alias Blog.Adapter.Schemas.Article

  schema "comments" do
    field :content, :string
    field :writer_id, :integer
    belongs_to :article, Article

    timestamps()
  end
end
