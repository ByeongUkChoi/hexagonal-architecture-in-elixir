defmodule Blog.ArticleTest do
  use Blog.DataCase

  alias Blog.Article

  describe "new/1" do
    # success test
    test "create new article test" do
      title = "Hello world"
      content = "hello world..."
      writer_id = 1

      assert {:ok,
              %{
                title: ^title,
                content: ^content,
                writer_id: ^writer_id
              }} = Article.new(title: title, content: content, writer_id: writer_id)
    end

    # failure test
    test "missing required argument test" do
      assert {:error, :missing_required_argument} == Article.new([])
      assert {:error, :missing_required_argument} == Article.new(title: "t", content: "c")
      assert {:error, :missing_required_argument} == Article.new(title: "t", writer_id: 1)
      assert {:error, :missing_required_argument} == Article.new(content: "c", writer_id: 1)

      assert {:error, :missing_required_argument} ==
               Article.new(title: 1, content: "c", writer_id: 1)

      assert {:error, :missing_required_argument} ==
               Article.new(title: "t", content: 1, writer_id: 1)

      assert {:error, :missing_required_argument} ==
               Article.new(title: "t", content: "c", writer_id: "i")

      assert {:error, :missing_required_argument} ==
               Article.new(title: nil, content: "c", writer_id: 1)

      assert {:error, :missing_required_argument} ==
               Article.new(title: "t", content: nil, writer_id: 1)

      assert {:error, :missing_required_argument} ==
               Article.new(title: "t", content: "c", writer_id: nil)
    end
  end
end
