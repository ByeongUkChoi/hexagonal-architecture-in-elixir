defmodule Blog.Article.Domain.Comment do
  defstruct [:id, :content, :article_id, :writer_id, :inserted_at, :updated_at]

  @type t :: %__MODULE__{
          id: integer() | nil,
          content: String.t(),
          inserted_at: DateTime.t() | nil,
          updated_at: DateTime.t() | nil
        }
  @type id :: integer()

  def new(content: content, article_id: article_id, writer_id: writer_id)
      when is_binary(content) and is_integer(article_id) and is_integer(writer_id) do
    comment = %__MODULE__{content: content, article_id: article_id, writer_id: writer_id}

    {:ok, comment}
  end

  def new(_) do
    {:error, :invalid_argument}
  end
end
