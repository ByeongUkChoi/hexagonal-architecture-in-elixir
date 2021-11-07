defmodule Blog.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :content, :string
      add :article_id, :integer
      add :writer_id, :integer

      timestamps()
    end
  end
end
