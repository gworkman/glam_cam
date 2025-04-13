defmodule GlamCam.Content.Tag do
  use Ash.Resource, otp_app: :glam_cam, domain: GlamCam.Content, data_layer: AshSqlite.DataLayer

  sqlite do
    table "tags"
    repo GlamCam.Repo
  end

  actions do
    defaults [:read, :destroy, create: :*, update: :*]
  end

  attributes do
    uuid_primary_key :id

    attribute :handle, :string do
      allow_nil? false
      public? true
    end

    attribute :did, :string do
      allow_nil? false
      public? true
    end

    timestamps()
  end

  relationships do
    belongs_to :post, GlamCam.Content.Post
  end
end
