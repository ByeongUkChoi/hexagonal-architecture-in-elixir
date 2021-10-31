defmodule Blog.Repo.Migrations.CreateArticles do
  use Ecto.Migration

  def change do
    create table(:articles) do
      add :title, :string
      add :content, :string
      add :writer_id, :integer

      timestamps()
    end
  end
end
