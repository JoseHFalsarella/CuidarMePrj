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

    has_many :thumbnails, Thumbnail
    belongs_to :comment, Comment

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(attachment, attrs) do
    attachment
    |> cast(attrs, [])
    |> validate_required([])
  end
end
