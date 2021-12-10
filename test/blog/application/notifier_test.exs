defmodule Blog.Application.NotifierTest do
  use Blog.DataCase

  import Mox

  alias Blog.Application.Notificater

  describe "notify_to_follower/2" do
    test "send email notification" do
      # given
      title = "Hello world"
      writer_id = 1
      follower_ids = [2, 3]
      followers = follower_ids |> Enum.map(&%{id: &1})

      Blog.MockFollowerRepo
      |> expect(:get_followers, fn ^writer_id ->
        {:ok, followers}
      end)

      Blog.MockEmailSender
      |> expect(:send, fn message: msg, to: to ->
        assert "[New feed] #{title}" == msg
        assert follower_ids == to |> Enum.sort()
        :ok
      end)

      assert :ok == Notificater.notify_to_follower(:email, title: title, writer_id: writer_id)
    end
  end
end
