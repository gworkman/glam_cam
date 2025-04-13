defmodule GlamCam.Content.Post do
  use Ash.Resource, otp_app: :glam_cam, domain: GlamCam.Content, data_layer: AshSqlite.DataLayer

  sqlite do
    table "posts"
    repo GlamCam.Repo
  end

  actions do
    defaults [:read, :destroy]

    read :published do
      filter expr(published == true)
    end

    update :publish do
      change set_attribute(:published, true)
    end

    create :create_with_data do
      argument :image, :uuid, allow_nil?: false
      argument :caption, :map, allow_nil?: false
      argument :tag, :map, allow_nil?: false

      change manage_relationship(:image, type: :append, value_is_key: :id)
      change manage_relationship(:caption, type: :create)
      change manage_relationship(:tag, type: :create)
    end
  end

  attributes do
    uuid_primary_key :id

    attribute :published?, :boolean do
      allow_nil? false
      default false
    end

    timestamps()
  end

  relationships do
    has_one :image, GlamCam.Content.Image
    has_one :caption, GlamCam.Content.Caption
    has_one :tag, GlamCam.Content.Tag
  end
end
