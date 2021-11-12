defmodule Blog.ArticleServiceTest do
  use Blog.DataCase

  import Mox

  alias Blog.ArticleService
  alias Blog.Domain.Article

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

  describe "update_article/1" do
    # success test
    test "create article success test" do
      # given
      article_id = 1
      title = "Hello world"
      content = "hello.."
      writer_id = 2
      now = DateTime.utc_now() |> DateTime.truncate(:second)

      article = %Article{
        id: article_id,
        title: title,
        content: content,
        writer_id: writer_id,
        inserted_at: now,
        updated_at: now
      }

      Blog.MockArticleRepo
      |> expect(:get, fn id ->
        assert article_id == id
        {:ok, article}
      end)

      updated_at = DateTime.utc_now() |> DateTime.truncate(:second)

      Blog.MockArticleRepo
      |> expect(:update, fn article ->
        {:ok, %{article | updated_at: updated_at}}
      end)

      updater_id = writer_id

      # when
      assert {:ok, actual_article} =
               ArticleService.update_article(article_id, %{
                 title: title,
                 content: content,
                 updater_id: updater_id
               })

      # then
      assert %{
               id: ^article_id,
               title: ^title,
               content: ^content,
               writer_id: ^updater_id,
               inserted_at: ^now,
               updated_at: ^updated_at
             } = actual_article
    end
  end
end
