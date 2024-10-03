defmodule CuidarMePrj.Groups do
  alias CuidarMePrj.Ticket
  use Ecto.Schema
  import Ecto.Changeset

  schema "groups" do
    field :url, :string
    field :name, :string
    field :is_public, :boolean
    field :description, :string
    field :default, :boolean
    field :deleted, :boolean
    field :created_at, :utc_datetime

    has_many :tickets, Ticket

    timestamps()
  end

  def changeset(group, attrs) do
    attrs = attrs || %{}
    fields = __MODULE__.__schema__(:fields)
    group
    |> cast(attrs, fields)
    |> unique_constraint(:id, name: :groups_pkey)
    |> validate_required([])
  end
end
