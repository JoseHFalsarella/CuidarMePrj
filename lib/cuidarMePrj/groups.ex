defmodule CuidarMePrj.Groups do
  use Ecto.Schema
  import Ecto.Changeset

  @field [:url, :name, :is_public, :descripton, :default, :deleted]

  schema "groups" do
    field :url, :string
    field :name, :string
    field :is_public, :boolean
    field :descripton, :string
    field :default, :boolean
    field :deleted, :boolean

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @field)
    |> validate_required(@field)
  end

end
