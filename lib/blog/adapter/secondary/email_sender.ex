defmodule Blog.Adapter.EmailSender do
  @behaviour Blog.Application.IEmailSender

  @impl true
  def send(message: _message, to: _to) do
    # impl...

    :ok
  end
end
