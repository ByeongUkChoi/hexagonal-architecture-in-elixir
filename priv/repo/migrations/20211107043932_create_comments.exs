defmodule Blog.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :content, :string
      add :article_id, :integer
      add :writer_id, :integer

      timestamps()
      add :deleted_at, :naive_datetime
    end
  end
end
