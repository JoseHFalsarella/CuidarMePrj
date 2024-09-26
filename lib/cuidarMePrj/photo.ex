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

    has_many :thumbnails, Thumbnail
    belongs_to :assignee, Assignee
    belongs_to :requester, Requester
    belongs_to :submitter, Submitter
    belongs_to :collaborator, Collaborator

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(photo, attrs) do
    photo
    |> cast(attrs, [])
    |> cast_assoc(:thumbnails)
    |> validate_required([])
  end
end
