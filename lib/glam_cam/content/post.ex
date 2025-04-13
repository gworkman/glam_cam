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

    create :create_with_image do
      argument :image, :map, allow_nil?: false

      change manage_relationship(:image, type: :create)

      change fn changeset, _context ->
        token =
          :crypto.strong_rand_bytes(32)
          |> Base.url_encode64()

        Ash.Changeset.change_attribute(changeset, :token, token)
      end
    end

    update :update do
      primary? true
      accept [:tag_bluesky_handle]
      argument :caption, :map

      change manage_relationship(:caption,
               on_lookup: :relate,
               on_no_match: :create,
               on_missing: :unrelate,
               on_match: :ignore
             )
    end
  end

  attributes do
    uuid_primary_key :id

    attribute :published?, :boolean do
      allow_nil? false
      default false
    end

    attribute :token, :string do
      allow_nil? false
    end

    attribute :tag_bluesky_handle, :string

    attribute :bluesky_link, :string

    timestamps()
  end

  relationships do
    has_one :image, GlamCam.Content.Image
    has_one :caption, GlamCam.Content.Caption
  end
end
