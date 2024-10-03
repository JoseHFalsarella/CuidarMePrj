defmodule CuidarMePrj.Repo.Migrations.AddGroupIdToTickets do
  use Ecto.Migration

  def change do
    alter table(:tickets) do
      add :groups_id, references(:groups)
    end
  end
end
