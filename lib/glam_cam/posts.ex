defmodule GlamCam.Posts do
  use Ash.Domain,
    otp_app: :glam_cam

  resources do
    resource GlamCam.Posts.Post
  end
end
