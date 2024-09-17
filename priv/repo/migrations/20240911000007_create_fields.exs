defmodule CuidarMePrj.Repo.Migrations.CreateFields do
  use Ecto.Migration

  def change do
    create table(:fields) do
      add :value, :string
      add :ticket_id, references(:tickets)
      timestamps(type: :utc_datetime)
    end
  end
end
