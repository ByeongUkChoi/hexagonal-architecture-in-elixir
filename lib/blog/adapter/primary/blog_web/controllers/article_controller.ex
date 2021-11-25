defmodule BlogWeb.ArticleController do
  use BlogWeb, :controller

  alias Blog.Application.ArticleService

  def show(conn, %{"id" => article_id}) do
    article = ArticleService.get_article(article_id)

    render(conn, "article.json", article)
  end
end
