defmodule Blog.ICommentRepo do
  alias Blog.Domain.Comment

  @callback insert(Comment.t()) :: {:ok, Comment.t()} | {:error, any()}
end
