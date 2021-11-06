defmodule Blog.Domain.CommentTest do
  use Blog.DataCase

  alias Blog.Domain.Comment

  describe "new/1" do
    # success test
    test "create new comment test" do
      content = "hello world..."
      article_id = 1
      writer_id = 1

      assert {:ok,
              %{
                content: ^content,
                article_id: ^article_id,
                writer_id: ^writer_id
              }} = Comment.new(content: content, article_id: article_id, writer_id: writer_id)
    end

    # failure test
    test "missing required argument test" do
      assert {:error, :missing_required_argument} == Comment.new([])
      assert {:error, :missing_required_argument} == Comment.new(content: "t", article_id: 1)
      assert {:error, :missing_required_argument} == Comment.new(content: "t", writer_id: 1)
      assert {:error, :missing_required_argument} == Comment.new(article_id: 1, writer_id: 1)
      assert {:error, :missing_required_argument} == Comment.new(content: "t")
      assert {:error, :missing_required_argument} == Comment.new(article_id: 1)
      assert {:error, :missing_required_argument} == Comment.new(writer_id: 1)

      assert {:error, :missing_required_argument} ==
               Comment.new(content: nil, article_id: 1, writer_id: 1)

      assert {:error, :missing_required_argument} ==
               Comment.new(content: "t", article_id: nil, writer_id: 1)

      assert {:error, :missing_required_argument} ==
               Comment.new(content: "t", article_id: 1, writer_id: nil)
    end
  end
end
