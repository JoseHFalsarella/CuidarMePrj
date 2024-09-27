defmodule CuidarMePrj.Photo do
  use Ecto.Schema
  import Ecto.Changeset

  alias CuidarMePrj.Collaborator
  alias CuidarMePrj.Requester
  alias CuidarMePrj.Submitter
  alias CuidarMePrj.Assignee
  alias CuidarMePrj.Thumbnail

  schema "photos" do
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
    field :inserted_at, :utc_datetime
    field :updated_at, :utc_datetime

    has_many :thumbnails, Thumbnail
    belongs_to :assignee, Assignee
    belongs_to :requester, Requester
    belongs_to :submitter, Submitter
    belongs_to :collaborator, Collaborator
  end

  @doc false
  def changeset(photo, attrs) do
    photo
    |> cast(attrs, [])
    |> cast_assoc(:thumbnails)
    |> unique_constraint(:id, name: :photos_pkey)
    |> validate_required([])
  end
end
