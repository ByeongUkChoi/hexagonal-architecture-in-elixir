defmodule Blog.Adapter.ArticleRepoTest do
  use Blog.DataCase

  alias Blog.Domain.Article, as: ArticleDomain

  alias Blog.Adapter.Schemas.Article, as: ArticleSchema
  alias Blog.Adapter.ArticleRepo

  alias Blog.Repo

  describe "insert/1" do
    test "return article domain including id, inserted_at and updated_at fileds" do
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
  end

  describe "update/1" do
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
  end
end
