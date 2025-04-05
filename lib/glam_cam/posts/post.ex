defmodule GlamCam.Posts.Post do
  use Ash.Resource, otp_app: :glam_cam, domain: GlamCam.Posts, data_layer: AshSqlite.DataLayer

  alias GlamCam.Posts.ImageToken
  alias GlamCam.Posts.PostedAtCalculation

  sqlite do
    table "posts"
    repo GlamCam.Repo
  end

  actions do
    defaults [:read]

    read :front_page do
      prepare build(sort: [inserted_at: :desc])
      filter expr(status == :posted)
    end

    create :upload do
      accept [:image]
      change set_attribute(:token, &ImageToken.generate/0)
    end

    update :post do
      change set_attribute(:status, :posted)
    end
  end

  attributes do
    uuid_primary_key :id

    attribute :image, :binary do
      allow_nil? false
    end

    attribute :token, :string do
      allow_nil? false
    end

    attribute :status, :atom do
      constraints one_of: [:pending, :posted]
      default :pending
      allow_nil? false
    end

    timestamps()
  end

  calculations do
    calculate :posted_at, :string, PostedAtCalculation
  end
end
