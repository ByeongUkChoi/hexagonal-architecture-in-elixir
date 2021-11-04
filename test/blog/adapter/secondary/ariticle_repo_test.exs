defmodule Blog.Adapter.ArticleRepoTest do
  use Blog.DataCase

  alias Blog.Domain.Article, as: ArticleDomain

  alias Blog.Adapter.Schemas.Article, as: ArticleSchema
  alias Blog.Adapter.ArticleRepo

  alias Blog.Repo

  describe "insert/1" do
    # success
    test "return article domain including id, inserted_at and updated_at fields" do
      # given
      article = %ArticleDomain{title: "t", content: "cc", writer_id: 1}

      # when
      assert {:ok,
              %ArticleDomain{
                id: id,
                title: title,
                content: content,
                writer_id: writer_id,
                inserted_at: inserted_at,
                updated_at: updated_at
              }} = ArticleRepo.insert(article)

      # then
      refute is_nil(id)
      assert article.title == title
      assert article.content == content
      assert article.writer_id == writer_id
      refute is_nil(inserted_at)
      refute is_nil(updated_at)
    end

    # failure
    test "insert article without title failure test" do
      article = %ArticleDomain{content: "cc", writer_id: 1}
      assert {:error, %Ecto.Changeset{}} = ArticleRepo.insert(article)
    end

    test "insert article without content failure test" do
      article = %ArticleDomain{title: "t", writer_id: 1}
      assert {:error, %Ecto.Changeset{}} = ArticleRepo.insert(article)
    end

    test "insert article without writer_id failure test" do
      article = %ArticleDomain{title: "t", content: "cc"}
      assert {:error, %Ecto.Changeset{}} = ArticleRepo.insert(article)
    end
  end

  describe "update/1" do
    # success
    test "update article with article id" do
      # given
      {:ok, %{id: article_id, writer_id: writer_id}} =
        Repo.insert(%ArticleSchema{title: "t", content: "c", writer_id: 1})

      new_title = "Hello new world"
      new_content = "hello new world...."

      new_article = %ArticleDomain{
        id: article_id,
        title: new_title,
        content: new_content
      }

      # when & then
      assert {:ok,
              %ArticleDomain{
                id: ^article_id,
                title: ^new_title,
                content: ^new_content,
                writer_id: ^writer_id
              }} = ArticleRepo.update(new_article)
    end

    # failure
    test "not found article id failure test" do
      not_found_article = %ArticleDomain{
        id: -1,
        title: "Hello new world",
        content: "hello new world...."
      }

      assert {:error, :not_found_article_schema} ==
               ArticleRepo.update(not_found_article)
               |> IO.inspect()
    end
  end
end
