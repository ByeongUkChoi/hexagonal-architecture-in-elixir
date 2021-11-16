defmodule Blog.CommentService do

  alias Blog.Adapter.Schemas.Comment, as: CommentSchema

  @comment_repo Application.get_env(:blog, :comment_repo)

  def get_comments(article_id: article_id) do
    @comment_repo.get_all_by_article_id(article_id)
    |> Enum.map(&CommentSchema.to_domain/1)
  end
end
