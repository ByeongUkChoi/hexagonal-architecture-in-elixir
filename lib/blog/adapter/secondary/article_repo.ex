defmodule Blog.ArticleRepo do
  # alias Blog.Repo

  @behaviour Blog.IArticleRepo

  @impl true
  def insert(article) do
    # TODO:
    {:ok, article}
  end
end
