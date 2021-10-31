defmodule Blog.Adapter.ArticleRepoTest do
  use Blog.DataCase

  alias Blog.Domain.Article
  alias Blog.Adapter.ArticleRepo

  describe "insert/1" do
    # success test
    test "return article domain including id, inserted_at and updated_at fileds" do
      # given
      article = %Article{title: "t", content: "cc", writer_id: 1}

      # when
      assert {:ok,
              %Article{
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
end
