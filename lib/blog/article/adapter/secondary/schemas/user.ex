defmodule Blog.Article.Adapter.Schemas.User do
  use Ecto.Schema

  schema "users" do
    field :username, :string
    field :name, :string
    field :email, :string

    timestamps()
  end
end
