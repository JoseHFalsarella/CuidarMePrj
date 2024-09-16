defmodule CuidarMePrj.Groups do
  alias CuidarMePrj.Ticket
  use Ecto.Schema
  import Ecto.Changeset

  @field [:url, :name, :is_public, :description, :default, :deleted]

  schema "groups" do
    field :url, :string
    field :name, :string
    field :is_public, :boolean
    field :description, :string
    field :default, :boolean
    field :deleted, :boolean

    belongs_to :ticket, Ticket

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @field)
    |> validate_required(@field)
  end

end
