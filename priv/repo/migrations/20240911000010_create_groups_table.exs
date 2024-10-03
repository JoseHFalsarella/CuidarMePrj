defmodule CuidarMePrj.Repo.Migrations.CreateGroupsTable do
  use Ecto.Migration

  def change do
    create table (:groups) do
      add :url, :string
      add :name, :string
      add :is_public, :boolean
      add :description, :string
      add :default, :boolean
      add :deleted, :boolean
      add :created_at, :utc_datetime
      timestamps()
    end
  end
end
