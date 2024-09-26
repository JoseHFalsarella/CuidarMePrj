defmodule CuidarMePrj.MetricSet do
  alias CuidarMePrj.Ticket
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
    field :reply_time_in_minutes, :map
    field :first_resolution_time_in_minutes, :map
    field :full_resolution_time_in_minutes , :map
    field :agent_wait_time_in_minutes, :map
    field :requester_wait_time_in_minutes, :map
    field :on_hold_time_in_minutes, :map
    field :custom_status_updated_at, :utc_datetime
    field :replies, :integer
    field :created_at, :utc_datetime

    belongs_to :ticket, Ticket

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(metric_set, attrs) do
    fields = CuidarMePrj.MetricSet.__schema__(:fields)
    metric_set
    |> cast(attrs, fields)
    |> validate_required([])
  end
end
