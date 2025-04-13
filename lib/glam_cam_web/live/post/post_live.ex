defmodule GlamCamWeb.PostLive do
  use GlamCamWeb, :live_view

  @impl true
  def mount(%{"post_id" => post_id} = params, _session, socket) do
    post = GlamCam.Content.get_post!(post_id)
    token = Map.get(params, "token")

    socket =
      socket
      |> maybe_assign_post_form(post, token)

    {:ok, assign(socket, post: post)}
  end

  @impl true
  def handle_event("validate", %{"form" => params}, socket) do
    params =
      params["caption"]
      |> update_in(fn caption ->
        if String.length(caption["text"]) > 0,
          do: Map.put(caption, "id", ""),
          else: caption
      end)

    form = AshPhoenix.Form.validate(socket.assigns.form, params)

    {:noreply, assign(socket, form: form)}
  end

  defp maybe_assign_post_form(socket, _post, nil), do: assign(socket, form: nil)

  defp maybe_assign_post_form(socket, post, token) do
    if :crypto.hash_equals(post.token, token) do
      form =
        post
        |> GlamCam.Content.form_to_update_post()
        |> to_form()

      captions =
        GlamCam.Content.list_available_captions!()
        |> Enum.shuffle()
        |> Enum.take(5)

      assign(socket, form: form, captions: captions)
    else
      assign(socket, form: nil)
    end
  end

  defp image_to_src(%GlamCam.Content.Image{type: type, data: data}),
    do: "data:image/#{type};base64,#{Base.encode64(data)}"
end
