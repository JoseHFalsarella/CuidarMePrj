defmodule CuidarMePrj.Collaborator do
  alias CuidarMePrj.Photo
  alias CuidarMePrj.Ticket
  use Ecto.Schema
  import Ecto.Changeset



  schema "collaborators" do

    field :url, :string
    field :name, :string
    field :email, :string
    field :time_zone, :string
    field :iana_time_zone, :string
    field :phone, :string
    field :shared_phone_number, :boolean
    field :locale_id, :integer
    field :locale, :string
    field :organization_id, :integer
    field :role, :string
    field :verified, :boolean
    field :external_id, :string
    field :tags, {:array, :binary}
    field :alias, :string
    field :active, :boolean
    field :shared, :boolean
    field :shared_agent, :boolean
    field :last_login_at, :utc_datetime
    field :two_factor_auth_enabled, :boolean
    field :signature, :string
    field :details, :string
    field :notes, :string
    field :role_type, :integer
    field :custom_role_id, :integer
    field :moderator, :boolean
    field :ticket_restriction, :string
    field :only_private_comments, :boolean
    field :restricted_agent, :boolean
    field :suspended, :boolean
    field :default_group_id, :integer
    field :report_csv, :boolean
    field :user_fields, :map
    field :created_at, :utc_datetime

    belongs_to :ticket, Ticket
    has_one :photo, Photo


    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(collaborator, attrs) do
    attrs = if is_list(attrs), do: %{}, else: attrs
    fields = __MODULE__.__schema__(:fields)
    collaborator =
      case collaborator do
        [] -> %__MODULE__{}
        _ -> collaborator
      end
    attrs = if is_map(attrs) do
      attrs
    else
      %{}
    end
    collaborator
    |> cast(attrs, fields)
    |> cast(attrs, [:tags], default: [])
    |> cast_assoc(:photo)
    |> unique_constraint(:id, name: :collaborators_pkey)
    |> validate_required([])
  end
end
