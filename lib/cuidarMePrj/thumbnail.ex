defmodule CuidarMePrj.Thumbnail do
  use Ecto.Schema
  import Ecto.Changeset

  alias CuidarMePrj.Photo
  alias CuidarMePrj.Attachment

  schema "thumbnails" do
    field :url, :string
    field :file_name, :string
    field :content_url, :string
    field :mapped_content_url, :string
    field :content_type, :string
    field :size, :integer
    field :width, :integer
    field :height, :integer
    field :inline, :boolean
    field :deleted, :boolean
    field :malware_access_override, :string
    field :malware_scan_result, :string

    belongs_to :attachment, Attachment
    belongs_to :photo, Photo
  end

  @doc false
  def changeset(thumbnail, attrs) do
    attrs = attrs || %{}
    fields = __MODULE__.__schema__(:fields)

    updated_attrs = Map.update(attrs, :malware_access_override, "", fn
      nil -> "nil"
      false -> "false"
      true -> "true"
      other -> to_string(other) |> String.slice(0, 255)
    end)

    thumbnail
    |> cast(updated_attrs, fields)
    |> unique_constraint(:id, name: :thumbnails_pkey)
    |> validate_required([])
  end
end
