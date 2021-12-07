defmodule Blog.Article.Adapter.ArticleView do
  use BlogWeb, :view

  def render("article.json", %{
        id: id,
        title: title,
        content: content,
        writer_id: writer_id,
        comments: comments,
        inserted_at: inserted_at,
        updated_at: updated_at
      }) do
    %{
      id: id,
      title: title,
      content: content,
      writer_id: writer_id,
      comments:
        comments
        |> Enum.map(fn comment ->
          %{
            id: comment.id,
            content: comment.content,
            writer_id: comment.writer_id,
            inserted_at: comment.inserted_at,
            updated_at: comment.updated_at
          }
        end),
      inserted_at: inserted_at,
      updated_at: updated_at
    }
  end

  def render("articles.json", %{articles: articles}) do
    articles
    |> Enum.map(fn article ->
      %{
        id: article.id,
        title: article.title,
        writer_id: article.writer_id,
        comments_count: length(article.comments),
        inserted_at: article.inserted_at,
        updated_at: article.updated_at
      }
    end)
  end
end
