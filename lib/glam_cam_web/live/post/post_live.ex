defmodule GlamCamWeb.PostLive do
  use GlamCamWeb, :live_view

  def mount(%{"post_id" => post_id}, _session, socket) do
    post = GlamCam.Content.get_post!(post_id)

    {:ok, assign(socket, post: post)}
  end

  defp image_to_src(%GlamCam.Content.Image{type: type, data: data}),
    do: "data:image/#{type};base64,#{Base.encode64(data)}"
end
