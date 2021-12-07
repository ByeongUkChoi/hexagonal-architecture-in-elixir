defmodule Blog.Application.Notificater do
  @email_sender Application.get_env(:blog, :email_sender)
  @follower_repo Application.get_env(:blog, :follower_repo)

  def notify_to_follower(:email, title: title, writer_id: writer_id) do
    with {:ok, followers} when followers != [] <- @follower_repo.get_follower(writer_id) do
      message = "[New feed] #{title}"
      @email_sender.send(message: message, to: followers)
    end
  end
end
