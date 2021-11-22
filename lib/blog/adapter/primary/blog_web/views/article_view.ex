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
      comments: comments |> Enum.map(&render("comment.json", &1)),
      inserted_at: inserted_at,
      updated_at: updated_at
    }
  end

  def render("comment.json", %{
        id: id,
        content: content,
        writer_id: writer_id,
        inserted_at: inserted_at,
        updated_at: updated_at
      }) do
    %{
      id: id,
      content: content,
      writer_id: writer_id,
      inserted_at: inserted_at,
      updated_at: updated_at
    }
  end
end
