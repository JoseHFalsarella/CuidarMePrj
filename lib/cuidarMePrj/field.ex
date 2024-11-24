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
    attrs = attrs || %{}
    fields = __MODULE__.__schema__(:fields)

    updated_attrs = Map.update(attrs, :value, "", fn
      nil -> "null"
      false -> "false"
      true -> "true"
      list when is_list(list) ->
        list
        |> List.first()
        |> to_string()
        |> String.slice(0, 255)
      other ->
        other
        |> to_string()
        |> String.slice(0, 255)
    end)

    field
    |> cast(updated_attrs, fields)
    |> unique_constraint(:id, name: :fields_pkey)
    |> validate_required([])
  end
end
