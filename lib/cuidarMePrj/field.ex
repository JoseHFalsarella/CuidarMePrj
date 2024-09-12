defmodule CuidarMePrj.Field do
  use Ecto.Schema
  import Ecto.Changeset

  schema "fields" do
    field :value, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(field, attrs) do
    field
    |> cast(attrs, [])
    |> validate_required([])
  end
end
