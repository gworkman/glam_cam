defmodule GlamCamWeb.HomeLive do
  use GlamCamWeb, :live_view

  def render(assigns) do
    ~H"""
    <div class="grid md:grid-cols-3 gap-4">
      <.link :for={{html_id, post} <- @streams.posts} navigate={~p"/post/#{post.id}"}>
        <img class="w-full" src={"data:image/png;base64," <> Base.encode64(post.image)} />
        <p class="text-sm text-center">Posted {post.posted_at}</p>
      </.link>
    </div>
    """
  end

  def handle_params(_params, _uri, socket) do
    {:ok, posts} = GlamCam.Posts.front_page(load: [:posted_at])
    socket = stream(socket, :posts, posts)

    {:noreply, socket}
  end
end
