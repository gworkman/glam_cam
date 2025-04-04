defmodule GlamCam.Posts.Post do
  use Ash.Resource, otp_app: :glam_cam, domain: GlamCam.Posts, data_layer: AshSqlite.DataLayer

  sqlite do
    table "posts"
    repo GlamCam.Repo
  end

  attributes do
    uuid_primary_key :id

    attribute :image, :binary do
      allow_nil? false
    end

    attribute :token, :string do
      allow_nil? false
    end

    attribute :body, :string
    timestamps()
  end
end
