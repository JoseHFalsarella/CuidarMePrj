defmodule CuidarMePrj.Comment do
  alias CuidarMePrj.Ticket
  alias CuidarMePrj.Attachment
  use Ecto.Schema
  import Ecto.Changeset

  schema "comments" do
    field :type, :string
    field :author_id, :integer
    field :body, :string
    field :html_body, :string
    field :plain_body, :string
    field :public, :boolean
    field :audit_id, :integer
    field :via, :map
    field :metadata, :map
    field :custom, :map
    field :created_at, :utc_datetime

    belongs_to :ticket, Ticket
    has_many :attachments, Attachment

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [])
    |> cast_assoc(:attachments)
    |> unique_constraint(:id, name: :comments_pkey)
    |> validate_required([])
  end
end
