defmodule GlamCam.Content do
  use Ash.Domain,
    otp_app: :glam_cam

  resources do
    resource GlamCam.Content.Image
    resource GlamCam.Content.Caption
    resource GlamCam.Content.Tag
    resource GlamCam.Content.Post
  end
end
