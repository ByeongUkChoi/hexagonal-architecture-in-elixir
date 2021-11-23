defmodule BlogWeb.ArticleViewTest do
  use BlogWeb.ConnCase, async: true

  import Phoenix.View

  alias BlogWeb.ArticleView

  describe "render(`article.json`)" do
    test "renders article.json" do
      article = %{
        id: 1,
        title: "Hello world",
        content: "hello world...",
        writer_id: 2,
        comments: [
          %{
            id: 3,
            content: "comment..",
            writer_id: 4,
            inserted_at: ~U[2021-11-24 13:04:36Z],
            updated_at: ~U[2021-11-25 13:04:36Z]
          },
          %{
            id: 5,
            content: "comment2..",
            writer_id: 6,
            inserted_at: ~U[2021-11-26 13:04:36Z],
            updated_at: ~U[2021-11-27 13:04:36Z]
          }
        ],
        inserted_at: ~U[2021-11-23 13:04:36Z],
        updated_at: ~U[2021-11-24 13:04:36Z]
      }

      assert article == render(ArticleView, "article.json", article)
    end
  end
end
