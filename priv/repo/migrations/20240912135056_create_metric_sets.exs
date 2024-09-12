defmodule CuidarMePrj.Repo.Migrations.CreateMetricSets do
  use Ecto.Migration

  def change do
    create table(:metric_sets) do

      add :url, :string
      add :group_stations, :integer
      add :assignee_stations, :integer
      add :reopens, :integer
      add :assignee_updated_at, :datetime
      add :requester_updated_at, :datetime
      add :status_updated_at, :datetime
      add :initially_assigned_at, :datetime
      add :assigned_at, :datetime
      add :solved_at, :datetime
      add :latest_comment_added_at, :datetime
      add :reply_time_in_minutes, :string
      add :first_resolution_time_in_minutes, :string
      add :full_resolution_time_in_minutes , :string
      add :agent_wait_time_in_minutes, :string
      add :requester_wait_time_in_minutes, :string
      add :on_hold_time_in_minutes, :string
      add :custom_status_updated_at, :datetime


      timestamps(type: :utc_datetime)
    end

    create unique_index(:metric_sets,[:url])

  end
end
