defmodule CuidarMePrj.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :type, :string
      add :author_id, :bigint
      add :body, :text
      add :html_body, :text
      add :plain_body, :text
      add :public, :boolean
      add :audit_id, :bigint
      add :via, :map
      add :metadata, :map
      add :custom, :map
      add :created_at, :utc_datetime
      add :ticket_id, references(:tickets)
      timestamps(type: :utc_datetime)
    end
  end
end
