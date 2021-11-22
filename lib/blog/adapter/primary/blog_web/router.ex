defmodule BlogWeb.Router do
  use BlogWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", BlogWeb do
    pipe_through :api

    scope "/articles" do
      get "/", ArticleController, :index
      post "/", ArticleController, :create
      delete "/", ArticleController, :delete

      scope "/:id" do
        get "/", ArticleController, :show
        post "/", ArticleController, :update

        scope "/comments" do
          get "/", CommentController, :index
          post "/", CommentController, :create
          post "/:id", CommentController, :update
        end
      end
    end
  end
end
