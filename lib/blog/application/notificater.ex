defmodule Blog.Application.Notificater do
  @email_sender Application.get_env(:blog, :email_sender)
  @follower_repo Application.get_env(:blog, :follower_repo)

  def notify_to_follower(:email, title: title, writer_id: writer_id) do
    with {:ok, followers} when followers != [] <- @follower_repo.get_followers(writer_id) do
      message = "[New feed] #{title}"
      follower_ids = Enum.map(followers, & &1.id)
      @email_sender.send(message: message, to: follower_ids)
    end
  end
end
