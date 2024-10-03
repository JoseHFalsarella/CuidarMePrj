defmodule CuidarMePrj.Attachment do
  alias CuidarMePrj.Comment
  alias CuidarMePrj.Thumbnail
  use Ecto.Schema
  import Ecto.Changeset

  schema "attachments" do
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
    field :malware_scan_result, :string
    field :malware_access_override, :string
    field :inserted_at, :utc_datetime
    field :updated_at, :utc_datetime

    has_many :thumbnails, Thumbnail
    belongs_to :comment, Comment
  end

  @doc false
  def changeset(attachment, attrs) do
    attrs = attrs || %{}
    attachment
    |> cast(attrs, [])
    |> cast_assoc(:thumbnails)
    |> unique_constraint(:id, name: :attachments_pkey)
    |> validate_required([])
  end
end
