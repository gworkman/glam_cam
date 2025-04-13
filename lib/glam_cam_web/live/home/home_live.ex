defmodule GlamCamWeb.HomeLive do
  use GlamCamWeb, :live_view

  def mount(_params, _session, socket) do
    posts = GlamCam.Content.list_posts!()

    {:ok, assign(socket, posts: posts)}
  end

  defp image_to_src(%GlamCam.Content.Image{type: type, data: data}),
    do: "data:image/#{type};base64,#{Base.encode64(data)}"
end
