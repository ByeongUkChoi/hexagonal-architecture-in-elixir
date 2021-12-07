defmodule Blog.Article.Domain.ArticleTest do
  use Blog.DataCase

  alias Blog.Article.Domain.Article

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

  describe "update/2" do
    # success
    test "update article test with title and content" do
      modified_title = "Hello world -- modified"
      modified_content = "hello world... -- modified"
      writer_id = 1

      article = %Article{writer_id: writer_id}

      assert {:ok, %{title: ^modified_title, content: ^modified_content}} =
               Article.update(article, %{
                 title: modified_title,
                 content: modified_content,
                 updater_id: writer_id
               })
    end

    test "update article test with title" do
      modified_title = "Hello world -- modified"
      writer_id = 1

      article = %Article{writer_id: writer_id}

      assert {:ok, %{title: ^modified_title}} =
               Article.update(article, %{title: modified_title, updater_id: writer_id})
    end

    test "update article test with content" do
      modified_content = "hello world... -- modified"
      writer_id = 1

      article = %Article{writer_id: writer_id}

      assert {:ok, %{content: ^modified_content}} =
               Article.update(article, %{content: modified_content, updater_id: writer_id})
    end

    # failure
    test "can not update except writer" do
      writer_id = 1
      updater_id = 2
      article = %Article{writer_id: writer_id}

      assert {:error, :invailed_updater_id} =
               Article.update(article, %{title: "t", updater_id: updater_id})
    end

    test "missing required params test" do
      writer_id = 1
      article = %Article{writer_id: writer_id}

      assert {:error, :missing_required_argument} =
               Article.update(article, %{updater_id: writer_id})
    end

    test "invalid params test" do
      assert {:error, :invalid_params} = Article.update(%{}, %{title: "t", updater_id: 1})
    end
  end

  describe "enable_delete?/1" do
    # success
    test "can delete when equals writer and deleter" do
      writer_id = 1
      article = %Article{writer_id: writer_id}

      assert true == Article.enable_delete?(article, deleter_id: writer_id)
    end

    # failure
    test "can not delete when diffrent writer and deleter" do
      writer_id = 1
      deleter_id = 2
      article = %Article{writer_id: writer_id}

      assert false == Article.enable_delete?(article, deleter_id: deleter_id)
    end
  end
end
