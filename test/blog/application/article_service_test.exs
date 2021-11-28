defmodule Blog.Application.ArticleServiceTest do
  use Blog.DataCase

  import Mox

  alias Blog.Application.ArticleService
  alias Blog.Domain.Article

  describe "get_article/1" do
    test "get article" do
      # given
      article_id = 1
      now = DateTime.utc_now() |> DateTime.truncate(:second)

      article = %Article{
        id: article_id,
        title: "Hello world",
        content: "hello...",
        writer_id: 2,
        inserted_at: now,
        updated_at: now
      }

      Blog.MockArticleRepo
      |> expect(:get, fn input_article_id ->
        assert article_id == input_article_id
        {:ok, article}
      end)

      # when
      assert {:ok, actual_article} = ArticleService.get_article(article_id)

      # then
      assert article.id == actual_article.id
      assert article.title == actual_article.title
      assert article.content == actual_article.content
      assert article.writer_id == actual_article.writer_id
      assert article.inserted_at == actual_article.inserted_at
      assert article.updated_at == actual_article.updated_at
    end

    test "not found article" do
      Blog.MockArticleRepo
      |> expect(:get, fn _ ->
        {:error, :not_found_article}
      end)

      assert {:error, :not_found_article} == ArticleService.get_article(-1)
    end
  end

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

    # failure
    test "update article invalid updater id failure test" do
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

      updater_id = 3

      # when & assert
      assert {:error, :invailed_updater_id} ==
               ArticleService.update_article(article_id, %{
                 title: title,
                 content: content,
                 updater_id: updater_id
               })
    end
  end
end
