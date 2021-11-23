defmodule BlogWeb.ArticleView do
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
end
