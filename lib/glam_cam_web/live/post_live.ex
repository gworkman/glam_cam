defmodule GlamCamWeb.PostLive do
  use GlamCamWeb, :live_view

  def render(assigns) do
    ~H"""
    <.link navigate={~p"/"}>&larr; Back to all posts</.link>
    <div class="w-full flex flex-col gap-4">
      <img class="w-full" src={"data:image/png;base64," <> Base.encode64(@post.image)} />
      <div class="flex flex-row items-center justify-between">
        <span :if={@post.status == :posted}>Posted {@post.posted_at}</span>
        <.button><.icon name="hero-arrow-down-tray" class="w-5 h-5" /> Download</.button>
      </div>
    </div>
    <.form :let={f} for={%{}} as={:post} class="my-12">
      <.input field={f[:credit_card]} placeholder="nervescam.bsky.social" class="pl-10">
        <:inner_prefix>
          <.icon name="hero-at-symbol" class="w-5 h-5" />
        </:inner_prefix>
      </.input>
    </.form>
    """
  end

  def handle_params(%{"post_id" => post_id}, _uri, socket) do
    {:ok, post} = GlamCam.Posts.post_by_id(post_id, load: [:posted_at])

    socket = assign(socket, post: post)

    {:noreply, socket}
  end
end
