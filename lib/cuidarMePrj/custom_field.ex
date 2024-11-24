defmodule CuidarMePrj.CustomField do
  use Ecto.Schema
  import Ecto.Changeset

  schema "custom_fields" do
    field :value, :string
    belongs_to :ticket, CuidarMePrj.Ticket
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(custom_field, attrs) do
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

    custom_field
    |> cast(updated_attrs, fields)
    |> unique_constraint(:id, name: :custom_fields_pkey)
    |> validate_required([])
  end
end
