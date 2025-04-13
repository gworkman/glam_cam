defmodule GlamCam.Content do
  use Ash.Domain,
    otp_app: :glam_cam

  resources do
    resource GlamCam.Content.Image do
      define :create_image, action: :create
    end

    resource GlamCam.Content.Caption
    resource GlamCam.Content.Tag
    resource GlamCam.Content.Post
  end
end
