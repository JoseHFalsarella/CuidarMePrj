defmodule CuidarMePrj.Repo.Migrations.CreateCustomFields do
  use Ecto.Migration

  def change do
    create table(:custom_fields) do
      add :value, :text
      timestamps(type: :utc_datetime)
    end
  end
end
