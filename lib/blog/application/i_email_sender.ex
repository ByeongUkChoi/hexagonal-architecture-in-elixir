defmodule Blog.Application.IEmailSender do
  @callback send(message: String.t(), to: list(integer())) :: :ok | {:error, any()}
end
