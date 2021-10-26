defmodule Blog.Article do
  defstruct [:id, :title, :content, :writer_id, :comments, :inserted_at, :updated_at]

  def new(title: title, content: content, writer_id: writer_id)
      when is_binary(title) and is_binary(content) and is_integer(writer_id) do
    article = %__MODULE__{title: title, content: content, writer_id: writer_id}

    {:ok, article}
  end

  def new(_), do: {:error, :missing_required_argument}
end
