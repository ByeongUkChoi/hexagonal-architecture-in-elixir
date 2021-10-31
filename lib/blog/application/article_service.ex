defmodule Blog.ArticleService do
  alias Blog.Domain.Article

  @article_repo Application.get_env(:blog, :article_repo)

  def create_article(title: title, content: content, writer_id: writer_id) do
    with {:ok, article} <- Article.new(title: title, content: content, writer_id: writer_id),
         {:ok, article} <- @article_repo.insert(article) do
      {:ok, article}
    end
  end
end
