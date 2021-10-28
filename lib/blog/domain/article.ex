defmodule Blog.Article do
  defstruct [:id, :title, :content, :writer_id, :comments]

  def new(title: title, content: content, writer_id: writer_id)
      when is_binary(title) and is_binary(content) and is_integer(writer_id) do
    article = %__MODULE__{title: title, content: content, writer_id: writer_id}

    {:ok, article}
  end

  def new(_), do: {:error, :missing_required_argument}

  def update(%{writer_id: writer_id}, %{updater_id: updater_id}) when writer_id != updater_id,
    do: {:error, :invailed_updater_id}

  def update(%__MODULE__{} = article, %{title: title, content: content, updater_id: _}) do
    article =
      article
      |> set_title(title)
      |> set_content(content)

    {:ok, article}
  end

  def update(%__MODULE__{} = article, %{title: title, updater_id: _}) do
    {:ok, set_title(article, title)}
  end

  def update(%__MODULE__{} = article, %{content: content, updater_id: _}) do
    {:ok, set_content(article, content)}
  end

  def update(%__MODULE__{}, _), do: {:error, :missing_required_argument}
  def update(_, _), do: {:error, :invalid_params}

  def enable_delete?(%__MODULE__{writer_id: writer_id}, deleter_id: writer_id), do: true
  def enable_delete?(_, _), do: false

  defp set_title(article, title) do
    %__MODULE__{article | title: title}
  end

  defp set_content(article, content) do
    %__MODULE__{article | content: content}
  end
end
