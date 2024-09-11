defmodule CuidarMePrj.Repo.Migrations.CreateGroupsTable do
  use Ecto.Migration

  def change do
    create table (:groups) do
      add :url, :string
      add :name, :string
      add :is_public, :boolean
      add :descripton, :string
      add :default, :boolean
      add :deleted, :boolean

      timestamps()
    end

    create unique_index(:groups,[:url])



  end
end
