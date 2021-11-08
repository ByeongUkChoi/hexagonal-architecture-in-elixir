defmodule Blog.Adapter.CommentRepoTest do
  use Blog.DataCase

  alias Blog.Domain.Comment, as: CommentDomain

  alias Blog.Adapter.Schemas.Comment, as: CommentSchema
  alias Blog.Adapter.Schemas.Article, as: ArticleSchema
  alias Blog.Adapter.CommentRepo

  alias Blog.Repo

  describe "insert/1" do
    # success
    test "return comment domain including id, inserted_at and updated_at fields" do
      # given
      {:ok, %{id: article_id}} =
        Repo.insert(%ArticleSchema{title: "t", content: "cc", writer_id: 1})

      writer_id = 2
      content = "comment..."

      # when
      assert {:ok, comment} =
               CommentRepo.insert(%CommentDomain{
                 content: content,
                 article_id: article_id,
                 writer_id: writer_id
               })

      # then
      assert is_integer(comment.id)
      assert comment.content == content
      assert comment.article_id == article_id
      assert comment.writer_id == writer_id
      refute is_nil(comment.inserted_at)
      refute is_nil(comment.updated_at)
    end

    # failure
    test "insert article without content failure test" do
      assert {:error, %Ecto.Changeset{}} =
               CommentRepo.insert(%CommentDomain{article_id: 1, writer_id: 1})
    end

    test "insert article without article id failure test" do
      assert {:error, %Ecto.Changeset{}} =
               CommentRepo.insert(%CommentDomain{content: "c", writer_id: 1})
    end

    test "insert article without writer id failure test" do
      assert {:error, %Ecto.Changeset{}} =
               CommentRepo.insert(%CommentDomain{article_id: 1, writer_id: 1})
    end

    test "insert article invalid article id failure test" do
      assert {:error, %Ecto.Changeset{}} =
               CommentRepo.insert(%CommentDomain{content: "c", article_id: 0, writer_id: 1})
    end

    test "insert article invalid writer id failure test" do
      assert {:error, %Ecto.Changeset{}} =
               CommentRepo.insert(%CommentDomain{content: "c", article_id: 1, writer_id: 0})
    end
  end
end
