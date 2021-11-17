defmodule Blog.CommentServiceTest do
  use Blog.DataCase

  import Mox

  alias Blog.CommentService
  alias Blog.Domain.Comment, as: CommentDomain
  alias Blog.Adapter.Schemas.Comment, as: CommentSchema

  describe "get_comments/1" do
    # success test
    test "get comments by article id test" do
      # given
      article_id = 1

      comment_schema1 = %CommentSchema{
        id: 1,
        content: "c1",
        writer_id: 2,
        article_id: article_id
      }

      comment_schema2 = %CommentSchema{
        id: 2,
        content: "c2",
        writer_id: 3,
        article_id: article_id
      }

      Blog.MockCommentRepo
      |> expect(:get_all_by_article_id, fn input_article_id ->
        assert article_id == input_article_id
        [comment_schema1, comment_schema2]
      end)

      # when
      assert comments = CommentService.get_comments(article_id: article_id)

      # then
      assert length(comments) == 2
      assert comment1 = comments |> Enum.find(&(&1.id == comment_schema1.id))
      assert comment1.id == comment_schema1.id
      assert comment1.content == comment_schema1.content
      assert comment1.writer_id == comment_schema1.writer_id
      assert comment1.article_id == comment_schema1.article_id

      assert comment2 = comments |> Enum.find(&(&1.id == comment_schema2.id))
      assert comment2.id == comment_schema2.id
      assert comment2.content == comment_schema2.content
      assert comment2.writer_id == comment_schema2.writer_id
      assert comment2.article_id == comment_schema2.article_id
    end
  end
end
