defmodule CuidarMePrj.Thumbnail do
  use Ecto.Schema
  import Ecto.Changeset

  alias CuidarMePrj.Photo

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

    belongs_to :photo, Photo

  end

  @doc false
  def changeset(thumbnail, attrs) do
    thumbnail
    |> cast(attrs, [])
    |> validate_required([])
  end
end
