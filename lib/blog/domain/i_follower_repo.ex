defmodule Blog.Domain.IFollowerRepo do
  @callback get_followers(integer()) :: {:ok, list()} | {:error, any()}
end
