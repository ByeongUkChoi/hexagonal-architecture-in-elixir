defmodule Blog.Application.ArticleService do
  alias Blog.Domain.Article

  @article_repo Application.get_env(:blog, :article_repo)

  def get_article(article_id) do
    @article_repo.get(article_id)
  end

  def create_article(title: title, content: content, writer_id: writer_id) do
    with {:ok, article} <- Article.new(title: title, content: content, writer_id: writer_id),
         {:ok, article} <- @article_repo.insert(article) do
      {:ok, article}
    end
  end

  def update_article(article_id, %{title: _, content: _, updater_id: _} = attr) do
    with {:ok, article} <- @article_repo.get(article_id),
         {:ok, article} <- Article.update(article, attr),
         {:ok, article} <- @article_repo.update(article) do
      {:ok, article}
    end
  end
end
