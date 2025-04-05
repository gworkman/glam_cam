defmodule GlamCam.Posts do
  use Ash.Domain,
    otp_app: :glam_cam

  resources do
    resource GlamCam.Posts.Post do
      define :post_by_id, action: :read, get_by: [:id]
      define :front_page
      define :upload_image, action: :upload, args: [:image]
    end
  end
end
