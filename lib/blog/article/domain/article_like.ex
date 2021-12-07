defmodule Blog.Article.Domain.ArticleLike do
  alias Blog.Article.Domain.Article

  defstruct [:id, :article_id, :user_id]

  @type t :: %__MODULE__{
          id: integer() | nil,
          article_id: Article.id(),
          user_id: integer()
        }
  @type id :: integer()
end
