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
  def changeset(field, attrs) do
    field
    |> cast(attrs, [])
    |> unique_constraint(:id, name: :fields_pkey)
    |> validate_required([])
  end
end
