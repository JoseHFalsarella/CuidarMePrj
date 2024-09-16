defmodule CuidarMePrj.Repo.Migrations.CreateCollaborators do
  use Ecto.Migration

  def change do
    create table(:collaborators) do

      add :url, :string
      add :name, :string
      add :email, :string
      add :time_zone, :string
      add :iana_time_zone, :string
      add :phone, :string
      add :shared_phone_nuber, :boolean
      add :locale_id, :integer
      add :locate, :string
      add :organization_id, :integer
      add :role, :string
      add :verified, :boolean
      add :external_id, :integer
      add :tags, :string
      add :alias, :string
      add :active, :boolean
      add :shared, :boolean
      add :shared_agent, :boolean
      add :last_login_at, :utc_datetime
      add :two_factor_auth, :boolean
      add :signature, :string
      add :details, :string
      add :notes, :string
      add :role_type, :integer
      add :custom_role_id, :integer
      add :moderator, :boolean
      add :ticket_restriction, :string
      add :only_private_comments, :boolean
      add :restricted_agent, :boolean
      add :suspended, :boolean
      add :default_group_id, :integer
      add :report_csv, :boolean
      add :user_fields, :map
      add :ticket_id, references(:tickets)

      timestamps(type: :utc_datetime)
    end
  end
end
