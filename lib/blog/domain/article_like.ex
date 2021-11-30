defmodule Blog.Domain.ArticleLike do
  alias Blog.Domain.Article

  defstruct [:id, :article_id, :user_id]

  @type t :: %__MODULE__{
          id: integer() | nil,
          article_id: Article.id(),
          user_id: integer()
        }
  @type id :: integer()
end
