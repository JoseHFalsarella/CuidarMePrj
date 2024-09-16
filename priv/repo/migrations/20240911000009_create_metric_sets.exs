defmodule CuidarMePrj.Repo.Migrations.CreateMetricSets do
  use Ecto.Migration

  def change do
    create table(:metric_sets) do

      add :url, :string
      add :group_stations, :integer
      add :assignee_stations, :integer
      add :reopens, :integer
      add :assignee_updated_at, :utc_datetime
      add :requester_updated_at, :utc_datetime
      add :status_updated_at, :utc_datetime
      add :initially_assigned_at, :utc_datetime
      add :assigned_at, :utc_datetime
      add :solved_at, :utc_datetime
      add :latest_comment_added_at, :utc_datetime
      add :reply_time_in_minutes, :map
      add :first_resolution_time_in_minutes, :map
      add :full_resolution_time_in_minutes , :map
      add :agent_wait_time_in_minutes, :map
      add :requester_wait_time_in_minutes, :map
      add :on_hold_time_in_minutes, :map
      add :custom_status_updated_at, :utc_datetime
      add :ticket_id, references(:tickets)

      timestamps(type: :utc_datetime)
    end

    create unique_index(:metric_sets,[:url])

  end
end
