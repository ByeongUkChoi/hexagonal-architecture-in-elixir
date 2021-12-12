defmodule Blog.Application.ArticleService do
  alias Blog.Domain.Article

  @article_repo Application.compile_env(:blog, :article_repo, Blog.Adapter.ArticleRepo)
  @article_like_repo Application.compile_env(:blog, :article_like_repo)
  @notificater Application.compile_env(:blog, :notificater, Blog.Application.Notificater)

  def get_article(article_id) do
    @article_repo.get(article_id)
  end

  def get_articles(page: page, size: size) do
    @article_repo.get_paged(page, size)
  end

  def create_article(title: title, content: content, writer_id: writer_id) do
    with {:ok, article} <- Article.new(title: title, content: content, writer_id: writer_id),
         {:ok, article} <- @article_repo.insert(article),
         :ok <- @notificater.notify_to_follower(:email, article) do
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

  def like_article(article_id: article_id, user_id: user_id) do
    with {:ok, _article} <- @article_repo.get(article_id),
         {:ok, _} <- @article_like_repo.like(article_id, user_id) do
      :ok
    end
  end
end
