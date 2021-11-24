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

  describe "render(`articles.json`)" do
    test "renders articles.json" do
      articles = [
        %{
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
        },
        %{
          id: 7,
          title: "Hello world2",
          content: "hello world2...",
          writer_id: 8,
          comments: [],
          inserted_at: ~U[2021-11-28 13:04:36Z],
          updated_at: ~U[2021-11-29 13:04:36Z]
        }
      ]

      assert [
               %{
                 id: 1,
                 title: "Hello world",
                 writer_id: 2,
                 comments_count: 2,
                 inserted_at: ~U[2021-11-23 13:04:36Z],
                 updated_at: ~U[2021-11-24 13:04:36Z]
               },
               %{
                 id: 7,
                 title: "Hello world2",
                 writer_id: 8,
                 comments_count: 0,
                 inserted_at: ~U[2021-11-28 13:04:36Z],
                 updated_at: ~U[2021-11-29 13:04:36Z]
               }
             ] == render(ArticleView, "articles.json", articles: articles)
    end
  end
end
