defmodule Blog.Article.Adapter.ArticleController do
  use BlogWeb, :controller

  alias Blog.Application.ArticleService

  def index(conn, params) do
    page = Map.get(params, "page", 0)
    size = Map.get(params, "size", 20)
    articles = ArticleService.get_articles(page: page, size: size)
    # TODO: comments

    render(conn, "articles.json", %{articles: articles})
  end

  def show(conn, %{"id" => article_id}) do
    article = ArticleService.get_article(article_id)

    render(conn, "article.json", article)
  end
end
