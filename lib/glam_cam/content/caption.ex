defmodule GlamCam.Content.Caption do
  use Ash.Resource, otp_app: :glam_cam, domain: GlamCam.Content, data_layer: AshSqlite.DataLayer

  sqlite do
    table "captions"
    repo GlamCam.Repo
  end

  attributes do
    uuid_primary_key :id

    attribute :text, :string do
      allow_nil? false
    end

    attribute :approved?, :boolean do
      allow_nil? false
    end

    timestamps()
  end

  relationships do
    belongs_to :post, GlamCam.Content.Post
  end
end
