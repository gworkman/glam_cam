defmodule GlamCam.Repo.Migrations.CreatePosts do
  @moduledoc """
  Updates resources based on their most recent snapshots.

  This file was autogenerated with `mix ash_sqlite.generate_migrations`
  """

  use Ecto.Migration

  def up do
    create table(:tags, primary_key: false) do
      add :post_id, references(:posts, column: :id, name: "tags_post_id_fkey", type: :uuid)
      add :updated_at, :utc_datetime_usec, null: false
      add :inserted_at, :utc_datetime_usec, null: false
      add :did, :text, null: false
      add :handle, :text, null: false
      add :id, :uuid, null: false, primary_key: true
    end

    create table(:posts, primary_key: false) do
      add :updated_at, :utc_datetime_usec, null: false
      add :inserted_at, :utc_datetime_usec, null: false
      add :published?, :boolean, null: false
      add :id, :uuid, null: false, primary_key: true
    end

    create table(:images, primary_key: false) do
      add :post_id, references(:posts, column: :id, name: "images_post_id_fkey", type: :uuid)
      add :updated_at, :utc_datetime_usec, null: false
      add :inserted_at, :utc_datetime_usec, null: false
      add :type, :text, null: false
      add :data, :binary, null: false
      add :id, :uuid, null: false, primary_key: true
    end

    create table(:captions, primary_key: false) do
      add :post_id, references(:posts, column: :id, name: "captions_post_id_fkey", type: :uuid)
      add :updated_at, :utc_datetime_usec, null: false
      add :inserted_at, :utc_datetime_usec, null: false
      add :approved?, :boolean, null: false
      add :text, :text, null: false
      add :id, :uuid, null: false, primary_key: true
    end
  end

  def down do
    drop constraint(:captions, "captions_post_id_fkey")

    drop table(:captions)

    drop constraint(:images, "images_post_id_fkey")

    drop table(:images)

    drop table(:posts)

    drop constraint(:tags, "tags_post_id_fkey")

    drop table(:tags)
  end
end