defmodule CuidarMePrj.Field do
  alias CuidarMePrj.Ticket
  use Ecto.Schema
  import Ecto.Changeset

  schema "fields" do
    field :value, :string

    belongs_to :ticket, Ticket

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(custom_field, attrs) do
    attrs = attrs || %{}
    custom_field
    |> cast(attrs, [])
    |> unique_constraint(:id, name: :custom_fields_pkey)
    |> validate_required([])
  end
end
