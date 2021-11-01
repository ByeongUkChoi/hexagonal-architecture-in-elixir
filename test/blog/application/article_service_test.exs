defmodule Blog.ArticleServiceTest do
  use Blog.DataCase

  alias Blog.ArticleService

  describe "create_article/1" do
    # success test
    test "create article success test" do
      # given
      title = "Hello world"
      content = "hello.."
      writer_id = 1

      # when
      assert {:ok, article} =
               ArticleService.create_article(title: title, content: content, writer_id: writer_id)

      # then
      assert %{
               title: ^title,
               content: ^content,
               writer_id: ^writer_id
             } = article

      refute is_nil(article.id)
      refute is_nil(article.inserted_at)
      refute is_nil(article.updated_at)
    end
  end
end
