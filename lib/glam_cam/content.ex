defmodule GlamCam.Content do
  use Ash.Domain,
    otp_app: :glam_cam

  resources do
    resource GlamCam.Content.Post do
      define :new_post, action: :create_with_image, args: [:image]
      define :list_posts, action: :read, default_options: [load: [:image]]
      define :get_post, action: :read, get_by: :id, default_options: [load: [:image]]
    end

    resource GlamCam.Content.Image
    resource GlamCam.Content.Caption
  end
end
