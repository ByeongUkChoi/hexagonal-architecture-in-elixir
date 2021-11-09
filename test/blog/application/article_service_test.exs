defmodule Blog.ArticleServiceTest do
  use Blog.DataCase

  import Mox

  alias Blog.ArticleService

  describe "create_article/1" do
    # success test
    test "create article success test" do
      # given
      id = 1
      title = "Hello world"
      content = "hello.."
      writer_id = 2
      now = DateTime.utc_now() |> DateTime.truncate(:second)

      Blog.MockArticleRepo
      |> expect(:insert, fn article ->
        {:ok, %{article | id: id, inserted_at: now, updated_at: now}}
      end)

      # when
      assert {:ok, article} =
               ArticleService.create_article(title: title, content: content, writer_id: writer_id)

      # then
      assert %{
               id: ^id,
               title: ^title,
               content: ^content,
               writer_id: ^writer_id,
               inserted_at: ^now,
               updated_at: ^now
             } = article
    end
  end
end
