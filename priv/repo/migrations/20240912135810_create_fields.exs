defmodule CuidarMePrj.Repo.Migrations.CreateFields do
  use Ecto.Migration

  def change do
    create table(:fields) do
      add :value, :text
      timestamps(type: :utc_datetime)
    end
  end
end
