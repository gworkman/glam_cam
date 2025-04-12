defmodule GlamCam.Content.Image do
  use Ash.Resource, otp_app: :glam_cam, domain: GlamCam.Content, data_layer: AshSqlite.DataLayer

  sqlite do
    table "images"
    repo GlamCam.Repo
  end

  attributes do
    uuid_primary_key :id

    attribute :data, :binary do
      allow_nil? false
    end

    attribute :type, :atom do
      allow_nil? false
    end

    timestamps()
  end

  relationships do
    belongs_to :post, GlamCam.Content.Post
  end
end
