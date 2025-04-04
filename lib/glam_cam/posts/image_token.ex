defmodule GlamCam.Posts.ImageToken do
  @token_bytes 8

  def generate do
    :crypto.strong_rand_bytes(@token_bytes)
    |> Base.url_encode64()
  end
end
