defmodule Blog.Article.Adapter.CommentRepoTest do
  use Blog.DataCase

  alias Blog.Article.Domain.Comment, as: CommentDomain

  alias Blog.Article.Adapter.Schemas.Comment, as: CommentSchema
  alias Blog.Article.Adapter.Schemas.Article, as: ArticleSchema
  alias Blog.Article.Adapter.CommentRepo

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

  describe "get_all_by_article_id/1" do
    # success
    test "get all comments by article id" do
      # given
      article_id = 1

      {:ok, %{id: comment1_id, content: comment1_content, writer_id: comment1_writer_id}} =
        Repo.insert(%CommentSchema{content: "c1", article_id: article_id, writer_id: 1})

      {:ok, %{id: comment2_id, content: comment2_content, writer_id: comment2_writer_id}} =
        Repo.insert(%CommentSchema{content: "c2", article_id: article_id, writer_id: 2})

      {:ok, %{id: comment3_id, content: comment3_content, writer_id: comment3_writer_id}} =
        Repo.insert(%CommentSchema{content: "c3", article_id: article_id, writer_id: 3})

      Repo.insert(%CommentSchema{content: "c4", article_id: 99991, writer_id: 1})
      Repo.insert(%CommentSchema{content: "c5", article_id: 99992, writer_id: 2})
      Repo.insert(%CommentSchema{content: "c6", article_id: 99993, writer_id: 3})

      # when
      comments = CommentRepo.get_all_by_article_id(article_id)

      # then
      assert Enum.sort([comment1_id, comment2_id, comment3_id]) ==
               comments |> Enum.map(& &1.id) |> Enum.sort()

      for comment <- comments, do: assert(article_id == comment.article_id)

      assert %{id: ^comment1_id, content: ^comment1_content, writer_id: ^comment1_writer_id} =
               comments |> Enum.find(&(&1.id == comment1_id))

      assert %{id: ^comment2_id, content: ^comment2_content, writer_id: ^comment2_writer_id} =
               comments |> Enum.find(&(&1.id == comment2_id))

      assert %{id: ^comment3_id, content: ^comment3_content, writer_id: ^comment3_writer_id} =
               comments |> Enum.find(&(&1.id == comment3_id))
    end

    test "return empty list if not exist comments" do
      assert [] == CommentRepo.get_all_by_article_id(1)
    end
  end
end
