defmodule Blog.Domain.Comment do
  defstruct [:id, :content, :article_id, :writer_id]

  def new(content: content, article_id: article_id, writer_id: writer_id)
      when is_binary(content) and is_integer(article_id) and is_integer(writer_id) do
    comment = %__MODULE__{content: content, article_id: article_id, writer_id: writer_id}

    {:ok, comment}
  end

  def new(_) do
    {:error, :missing_required_argument}
  end
end
