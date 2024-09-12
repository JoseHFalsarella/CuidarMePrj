defmodule CuidarMePrj.Ticket do
  alias CuidarMePrj.Field
  alias CuidarMePrj.CustomField
  use Ecto.Schema
  import Ecto.Changeset

  schema "tickets" do
    field :url, :string
    field :external_id, :string
    field :via, :map
    field :generated_timestamp, :utc_datetime
    field :type, :string
    field :subject, :string
    field :raw_subject, :string
    field :follower_ids, :map
    field :email_cc_ids, :map
    field :forum_topic_id, :integer
    field :problem_id, :integer
    field :has_incidents, :boolean
    field :is_public, :boolean
    field :due_at, :utc_datetime
    field :tags, :string
    field :satisfaction_rating, :integer
    field :sharing_agreement_ids, :map
    field :custom_status_id, :integer
    field :followup_ids, :map
    field :ticket_form_id, :integer
    field :brand_id, :integer
    field :dates, :map
    field :allow_channelback, :boolean
    field :allow_attachments, :boolean
    field :from_messaging_channel, :boolean
    field :collaborator_id, :map
    field :recipient, :string
    field :organization, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(ticket, attrs) do
    ticket
    |> cast(attrs, [])
    |> validate_required([])
  end
end
