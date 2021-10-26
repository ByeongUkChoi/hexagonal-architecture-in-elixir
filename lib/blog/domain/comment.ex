defmodule Blog.Comment do
  defstruct [:id, :content, :article_id, :writer, :inserted_at, :updated_at]
end
