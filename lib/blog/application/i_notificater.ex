defmodule Blog.Application.INotificater do
  @callback notify_to_follower(atom(), map()) :: :ok | {:error, any}
end
