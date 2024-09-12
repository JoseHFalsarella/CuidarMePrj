defmodule CuidarMePrj.MetricSet do
  use Ecto.Schema
  import Ecto.Changeset

  schema "metric_sets" do

  field :url, :string
  field :group_stations, :integer
  field :assignee_stations, :integer
  field :reopens, :integer
  field :assignee_updated_at, :utc_datetime
  field :requester_updated_at, :utc_datetime
  field :status_updated_at, :utc_datetime
  field :initially_assigned_at, :utc_datetime
  field :assigned_at, :utc_datetime
  field :solved_at, :utc_datetime
  field :latest_comment_added_at, :utc_datetime
  field :reply_time_in_minutes, :string
  field :first_resolution_time_in_minutes, :string
  field :full_resolution_time_in_minutes , :string
  field :agent_wait_time_in_minutes, :string
  field :requester_wait_time_in_minutes, :string
  field :on_hold_time_in_minutes, :string
  field :custom_status_updated_at, :utc_datetime


    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(metric_set, attrs) do
    metric_set
    |> cast(attrs, [])
    |> validate_required([])
  end
end
