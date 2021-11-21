defmodule Blog.CommentServiceTest do
  use Blog.DataCase

  import Mox

  alias Blog.CommentService
  alias Blog.Domain.{Article, Comment}

  describe "get_comments/1" do
    # success test
    test "get comments by article id test" do
      # given
      article_id = 1

      comment1 = %Comment{
        id: 1,
        content: "c1",
        writer_id: 2,
        article_id: article_id
      }

      comment2 = %Comment{
        id: 2,
        content: "c2",
        writer_id: 3,
        article_id: article_id
      }

      Blog.MockCommentRepo
      |> expect(:get_all_by_article_id, fn input_article_id ->
        assert article_id == input_article_id
        [comment1, comment2]
      end)

      # when
      assert comments = CommentService.get_comments(article_id: article_id)

      # then
      assert length(comments) == 2
      assert comment1 = comments |> Enum.find(&(&1.id == comment1.id))
      assert comment1.id == comment1.id
      assert comment1.content == comment1.content
      assert comment1.writer_id == comment1.writer_id
      assert comment1.article_id == comment1.article_id

      assert comment2 = comments |> Enum.find(&(&1.id == comment2.id))
      assert comment2.id == comment2.id
      assert comment2.content == comment2.content
      assert comment2.writer_id == comment2.writer_id
      assert comment2.article_id == comment2.article_id
    end
  end

  describe "create_comment/1" do
    # success
    test "create comment test" do
      # given
      content = "hello world!"
      article_id = 1
      writer_id = 2
      now = DateTime.utc_now() |> DateTime.truncate(:second)

      Blog.MockArticleRepo
      |> expect(:get, fn input_article_id ->
        assert article_id == input_article_id

        {:ok, %Article{id: article_id}}
      end)

      Blog.MockCommentRepo
      |> expect(:insert, fn input_comment ->
        assert content == input_comment.content
        assert article_id == input_comment.article_id
        assert writer_id == input_comment.writer_id

        {:ok, %{input_comment | id: 1, inserted_at: now, updated_at: now}}
      end)

      # when
      assert {:ok, comment} =
               CommentService.create_comment(
                 content: content,
                 article_id: article_id,
                 writer_id: writer_id
               )

      # then
      refute is_nil(comment.id)
      assert content == comment.content
      assert article_id == comment.article_id
      assert writer_id == comment.writer_id
      assert now == comment.inserted_at
      assert now == comment.updated_at
    end

    # failure
    test "create comment not found article failure test" do
      # given
      Blog.MockArticleRepo
      |> expect(:get, fn _ ->
        {:error, :not_found_article}
      end)

      # when & then
      assert {:error, :not_found_article} =
               CommentService.create_comment(content: "c", article_id: 1, writer_id: 1)
    end
  end
end
